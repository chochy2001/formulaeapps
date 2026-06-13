import type { Next } from 'hono';
import { randomUUID, createHash } from 'node:crypto';
import { env } from '../lib/env';
import type { AppContext } from '../lib/openapi';

type LogRecord = {
  ts: string;
  level: 'info' | 'warn' | 'error';
  request_id: string;
  method: string;
  route: string;
  status: number;
  latency_ms: number;
  client_ip_hash?: string;
  user_agent?: string;
  error_kind?: string;
};

function hashIp(ip: string): string {
  return createHash('sha256').update(ip).digest('hex').slice(0, 16);
}

function emit(record: LogRecord): void {
  // stdout JSON line, picked up by Docker → Promtail → Loki on the VPS.
  // No JWT, no OPENROUTER_API_KEY, no IAP receipts, no PII beyond hashed IP.
  // eslint-disable-next-line no-console
  console.log(JSON.stringify(record));
}

/**
 * Structured logging middleware. Emits one JSON line per request, redacted
 * of secrets per spec §FR-028 and research §R9. Generates a request_id for
 * each request and propagates it via context.
 */
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export async function loggerMiddleware(c: AppContext, next: Next): Promise<void> {
  // Only trust an inbound correlation id if it is a real UUID; otherwise mint a
  // fresh one. Prevents arbitrary client strings from leaking into structured
  // logs (log-correlation spoofing) and keeps request_id matching the OpenAPI
  // contract (request_id: uuid) in every emitted envelope.
  const incoming = c.req.header('x-request-id');
  const requestId = incoming && UUID_RE.test(incoming) ? incoming : randomUUID();
  c.set('request_id', requestId);
  c.header('X-Request-Id', requestId);

  const started = performance.now();
  const method = c.req.method;
  const route = c.req.path;
  const ua = c.req.header('user-agent')?.slice(0, 200);
  const clientIp =
    c.req.header('cf-connecting-ip') ?? c.req.header('x-forwarded-for')?.split(',')[0]?.trim();

  try {
    await next();
  } finally {
    const latency_ms = Math.round(performance.now() - started);
    const status = c.res?.status ?? 0;
    const record: LogRecord = {
      ts: new Date().toISOString(),
      level: status >= 500 ? 'error' : status >= 400 ? 'warn' : 'info',
      request_id: requestId,
      method,
      route,
      status,
      latency_ms,
      ...(clientIp ? { client_ip_hash: hashIp(clientIp) } : {}),
      ...(ua ? { user_agent: ua } : {}),
    };

    if (env.LOG_LEVEL !== 'debug' || record.level !== 'info') {
      emit(record);
    } else {
      emit(record);
    }
  }
}
