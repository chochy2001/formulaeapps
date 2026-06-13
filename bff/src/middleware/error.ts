import type { Context } from 'hono';
import { randomUUID } from 'node:crypto';
import { ZodError } from 'zod';
import { errorEnvelope, type ErrorKind } from '../schemas/error';
import type { AppEnv } from '../lib/openapi';

/**
 * Hono onError handler — maps uncaught errors to the ErrorEnvelope contract
 * shape (spec §FR-022, §FR-028, data-model §E8). Never leaks stack traces,
 * secret material, or upstream provider bodies to the client.
 */
export function errorHandler(err: unknown, c: Context<AppEnv>): Response {
  // request_id is normally set by loggerMiddleware (always a valid UUID). Fall
  // back to a fresh UUID — never a non-UUID literal — so the emitted envelope
  // always satisfies the contract's request_id: uuid field.
  const requestId = c.get('request_id') ?? randomUUID();

  // Zod validation errors → bad_request
  if (err instanceof ZodError) {
    const firstIssue = err.issues[0];
    const message = firstIssue
      ? `${firstIssue.path.join('.') || 'request'}: ${firstIssue.message}`
      : 'Invalid request payload';
    return c.json(errorEnvelope('bad_request', message, requestId, 'E_VALIDATION'), 400);
  }

  // Tagged errors with .kind property
  if (err && typeof err === 'object' && 'kind' in err && 'message' in err) {
    const tagged = err as { kind: ErrorKind; message: string; code?: string };
    const status = statusForKind(tagged.kind);
    return c.json(
      errorEnvelope(tagged.kind, tagged.message, requestId, tagged.code ?? 'E_TAGGED_ERROR'),
      status,
    );
  }

  // Unknown error — never leak details
  return c.json(
    errorEnvelope(
      'internal_error',
      'An internal error occurred. Reference request_id for support.',
      requestId,
      'E_INTERNAL',
    ),
    500,
  );
}

function statusForKind(kind: ErrorKind): 400 | 401 | 403 | 404 | 429 | 500 | 502 {
  switch (kind) {
    case 'bad_request':
      return 400;
    case 'unauthorized':
      return 401;
    case 'forbidden':
      return 403;
    case 'not_found':
      return 404;
    case 'rate_limited':
      return 429;
    case 'upstream_error':
      return 502;
    case 'internal_error':
    default:
      return 500;
  }
}

/**
 * Helper to throw a tagged error from inside a handler. The errorHandler
 * above catches it and emits the ErrorEnvelope automatically.
 */
export class BffError extends Error {
  public readonly kind: ErrorKind;
  public readonly code: string;
  constructor(kind: ErrorKind, message: string, code: string) {
    super(message);
    this.kind = kind;
    this.code = code;
  }
}
