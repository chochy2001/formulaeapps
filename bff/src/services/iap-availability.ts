import { env, type Env } from '../lib/env';

/**
 * Runtime check for Apple/Google IAP secret availability.
 *
 * Source of truth for the contract and operational context:
 * contracts/bff.openapi.yaml and docs/TICKETS.md (FML-115/FML-117). In
 * production the BFF needs:
 *   Apple:  APPLE_P8_FILE (path) + APPLE_ISSUER_ID + APPLE_KEY_ID + APPLE_BUNDLE_ID
 *   Google: GOOGLE_SA_FILE (path) + GOOGLE_PACKAGE_NAME
 *
 * When secrets haven't been dropped yet (T061 pending), placeholder env values
 * like "changeme" or "replace-with-issuer-uuid" cause the upstream SDKs
 * (jsonwebtoken, googleapis) to fail at construction with ugly errors. This
 * helper detects the unhealthy state at request time so /iap/validate can
 * return a clean 503 envelope, and at boot time so ops sees one warning line.
 *
 * Semantics:
 *  - In development, if the relevant env vars are entirely undefined: returns
 *    { available: true }. This preserves the explicit local/test path where
 *    the factory falls back to a stub validator that responds 200 +
 *    valid=false.
 *  - In staging/production, an entirely absent provider configuration is
 *    unavailable. A deployment must never make a receipt-validation request
 *    look like a completed validation merely because it reached a local stub.
 *  - If env vars are set but match a placeholder pattern, or files are
 *    missing/empty/malformed: returns { available: false, reason: '...' }.
 */

export type IapPlatform = 'apple' | 'google';

export type IapAvailability =
  | { available: true }
  | { available: false; reason: string };

/** The IAP-relevant portion of the process environment. */
export type IapAvailabilityRuntime = Pick<
  Env,
  | 'BFF_ENV'
  | 'APPLE_P8_FILE'
  | 'APPLE_ISSUER_ID'
  | 'APPLE_KEY_ID'
  | 'APPLE_BUNDLE_ID'
  | 'GOOGLE_SA_FILE'
  | 'GOOGLE_PACKAGE_NAME'
>;

type FileTextReader = (path: string) => Promise<string | undefined>;

// Both RealValidator classes deliberately throw E_*_IAP_NOT_READY until their
// provider integrations have been implemented and verified with sandbox
// receipts. Keep availability fail-closed while that is true; changing either
// value to true requires the real validation implementation and its live
// sandbox regression evidence in the same delivery.
const realValidatorImplemented: Readonly<Record<IapPlatform, boolean>> = {
  apple: false,
  google: false,
};

// Case-insensitive substrings that, when found in an env var value, indicate
// the value is a placeholder rather than a real secret. Combines workspace
// conventions (PLACEHOLDER_DEV_NOT_FOR_PROD, replace-with-*, replace-me) with
// common docker/compose templates (changeme, your_*_here, <your...>).
const PLACEHOLDER_SUBSTRINGS = [
  'changeme',
  'placeholder',
  'replace-me',
  'replace_me',
  'replace-with',
  'your_',
  '_here',
  '<your',
];

function isPlaceholder(value: string | undefined): boolean {
  if (value === undefined) return false;
  const trimmed = value.trim();
  if (trimmed.length === 0) return true;
  const lower = trimmed.toLowerCase();
  return PLACEHOLDER_SUBSTRINGS.some((p) => lower.includes(p));
}

async function readFileText(path: string): Promise<string | undefined> {
  try {
    const file = Bun.file(path);
    if (!(await file.exists())) return undefined;
    return await file.text();
  } catch {
    return undefined;
  }
}

function missingProviderConfiguration(
  platform: IapPlatform,
  runtime: IapAvailabilityRuntime,
): IapAvailability {
  // The stub is a purposeful local-development aid only. Staging and
  // production must communicate that no provider validation happened.
  if (runtime.BFF_ENV === 'development') return { available: true };
  return { available: false, reason: `${platform}_not_configured` };
}

function realValidatorAvailability(platform: IapPlatform): IapAvailability {
  if (realValidatorImplemented[platform]) return { available: true };
  return { available: false, reason: `${platform}_validator_not_ready` };
}

async function checkApple(
  runtime: IapAvailabilityRuntime,
  readFile: FileTextReader,
): Promise<IapAvailability> {
  const issuerId = runtime.APPLE_ISSUER_ID;
  const keyId = runtime.APPLE_KEY_ID;
  const bundleId = runtime.APPLE_BUNDLE_ID;
  const p8Path = runtime.APPLE_P8_FILE;

  const noneConfigured =
    issuerId === undefined &&
    keyId === undefined &&
    bundleId === undefined &&
    p8Path === undefined;
  if (noneConfigured) return missingProviderConfiguration('apple', runtime);

  if (issuerId === undefined || issuerId.trim().length === 0)
    return { available: false, reason: 'apple_issuer_id_missing' };
  if (isPlaceholder(issuerId))
    return { available: false, reason: 'apple_issuer_id_placeholder' };

  if (keyId === undefined || keyId.trim().length === 0)
    return { available: false, reason: 'apple_key_id_missing' };
  if (isPlaceholder(keyId))
    return { available: false, reason: 'apple_key_id_placeholder' };

  if (bundleId === undefined || bundleId.trim().length === 0)
    return { available: false, reason: 'apple_bundle_id_missing' };
  if (isPlaceholder(bundleId))
    return { available: false, reason: 'apple_bundle_id_placeholder' };

  if (p8Path === undefined || p8Path.trim().length === 0)
    return { available: false, reason: 'apple_p8_path_missing' };

  const p8Contents = await readFile(p8Path);
  if (p8Contents === undefined)
    return { available: false, reason: 'apple_p8_file_missing' };
  if (p8Contents.trim().length === 0)
    return { available: false, reason: 'apple_p8_file_empty' };
  // Apple p8 keys are PKCS#8 PEM blocks; sanity-check the header so we don't
  // hand jsonwebtoken a placeholder string and let it crash later.
  if (!p8Contents.includes('-----BEGIN PRIVATE KEY-----'))
    return { available: false, reason: 'apple_p8_file_invalid' };

  return realValidatorAvailability('apple');
}

async function checkGoogle(
  runtime: IapAvailabilityRuntime,
  readFile: FileTextReader,
): Promise<IapAvailability> {
  const saPath = runtime.GOOGLE_SA_FILE;
  const packageName = runtime.GOOGLE_PACKAGE_NAME;

  const noneConfigured = saPath === undefined && packageName === undefined;
  if (noneConfigured) return missingProviderConfiguration('google', runtime);

  if (packageName === undefined || packageName.trim().length === 0)
    return { available: false, reason: 'google_package_name_missing' };
  if (isPlaceholder(packageName))
    return { available: false, reason: 'google_package_name_placeholder' };

  if (saPath === undefined || saPath.trim().length === 0)
    return { available: false, reason: 'google_sa_path_missing' };

  const saContents = await readFile(saPath);
  if (saContents === undefined)
    return { available: false, reason: 'google_sa_missing' };
  if (saContents.trim().length === 0)
    return { available: false, reason: 'google_sa_empty' };

  let parsed: unknown;
  try {
    parsed = JSON.parse(saContents);
  } catch {
    return { available: false, reason: 'google_sa_invalid_json' };
  }
  if (
    !parsed ||
    typeof parsed !== 'object' ||
    typeof (parsed as { client_email?: unknown }).client_email !== 'string' ||
    ((parsed as { client_email: string }).client_email).trim().length === 0
  ) {
    return { available: false, reason: 'google_sa_missing_client_email' };
  }

  return realValidatorAvailability('google');
}

/**
 * Returns whether the named IAP platform is configured well enough that the
 * upstream SDK can be safely constructed. Cheap on the happy path (a few env
 * reads + at most one file stat/read). Called per-request from the handler
 * AND once at boot from src/index.ts.
 */
export async function checkIapAvailabilityForRuntime(
  platform: IapPlatform,
  runtime: IapAvailabilityRuntime,
  readFile: FileTextReader = readFileText,
): Promise<IapAvailability> {
  if (platform === 'apple') return checkApple(runtime, readFile);
  return checkGoogle(runtime, readFile);
}

/**
 * Check the current process configuration. Route handlers should use this
 * production entrypoint; the runtime overload above is exported so the policy
 * can be regression-tested without mutating the process environment.
 */
export async function checkIapAvailability(
  platform: IapPlatform,
): Promise<IapAvailability> {
  return checkIapAvailabilityForRuntime(platform, env);
}

/**
 * Convenience used by the startup banner. Renders a single token like
 * "ok" or "missing(apple_p8_file_missing)" — short, greppable in logs.
 */
export function formatAvailability(result: IapAvailability): string {
  return result.available ? 'ok' : `missing(${result.reason})`;
}
