import type { Context } from 'hono';
import { randomUUID } from 'node:crypto';
import { ZodError } from 'zod';
import { errorEnvelope, type ErrorKind } from '../schemas/error';
import type { AppEnv } from '../lib/openapi';

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const ERROR_CODE_RE = /^E_[A-Z0-9_]+$/;
const MAX_ERROR_MESSAGE_LENGTH = 200;
const ERROR_KINDS = new Set<ErrorKind>([
  'unauthorized',
  'forbidden',
  'not_found',
  'bad_request',
  'upstream_error',
  'rate_limited',
  'internal_error',
]);

/** Generic, client-safe wording for an unavailable provider or dependency. */
export const UPSTREAM_ERROR_MESSAGE =
  'The requested service is temporarily unavailable. Please try again.';

const INTERNAL_ERROR_MESSAGE =
  'An internal error occurred. Reference request_id for support.';

function normalizedRequestId(c: Context<AppEnv>): string {
  const requestId = c.get('request_id');
  return typeof requestId === 'string' && UUID_RE.test(requestId)
    ? requestId
    : randomUUID();
}

function normalizedKind(kind: unknown): ErrorKind {
  return typeof kind === 'string' && ERROR_KINDS.has(kind as ErrorKind)
    ? (kind as ErrorKind)
    : 'internal_error';
}

function boundedMessage(message: string, fallback: string): string {
  const trimmed = message.trim();
  return (trimmed || fallback).slice(0, MAX_ERROR_MESSAGE_LENGTH);
}

function clientMessage(kind: ErrorKind, message: string): string {
  if (kind === 'upstream_error') return UPSTREAM_ERROR_MESSAGE;
  if (kind === 'internal_error') return INTERNAL_ERROR_MESSAGE;
  return boundedMessage(message, 'Request failed.');
}

function clientCode(kind: ErrorKind, code: unknown): string {
  if (typeof code === 'string' && ERROR_CODE_RE.test(code)) return code;
  return kind === 'upstream_error' ? 'E_UPSTREAM_ERROR' : 'E_INTERNAL';
}

/**
 * Hono onError handler — maps uncaught errors to the ErrorEnvelope contract
 * shape (spec §FR-022, §FR-028, data-model §E8). Never leaks stack traces,
 * secret material, or upstream provider bodies to the client.
 */
export function errorHandler(err: unknown, c: Context<AppEnv>): Response {
  // loggerMiddleware normally sets a UUID. Validate it again here because this
  // handler may also run in isolated tests or future middleware order changes.
  const requestId = normalizedRequestId(c);

  // Zod validation errors → bad_request
  if (err instanceof ZodError) {
    const firstIssue = err.issues[0];
    const message = firstIssue
      ? `${firstIssue.path.join('.') || 'request'}: ${firstIssue.message}`
      : 'Invalid request payload';
    return c.json(
      errorEnvelope(
        'bad_request',
        boundedMessage(message, 'Invalid request payload'),
        requestId,
        'E_VALIDATION',
      ),
      400,
    );
  }

  // Only errors created by this module are allowed to select a public kind,
  // message, or code. A provider response can resemble a tagged error; treating
  // arbitrary objects as trusted would leak its raw message/type to the client.
  if (err instanceof BffError) {
    const kind = normalizedKind(err.kind);
    const status = statusForKind(kind);
    return c.json(
      errorEnvelope(
        kind,
        clientMessage(kind, err.message),
        requestId,
        clientCode(kind, err.code),
      ),
      status,
    );
  }

  // Unknown error — never leak details
  return c.json(
    errorEnvelope(
      'internal_error',
      INTERNAL_ERROR_MESSAGE,
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
    this.name = 'BffError';
    this.kind = kind;
    this.code = code;
  }
}
