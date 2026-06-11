import { describe, test, expect } from 'bun:test';
import { createRateLimiter, clientIpFromContext, shortHash } from '../../src/middleware/rate-limit';
import type { AppContext } from '../../src/lib/openapi';

// Minimal fake context: only the surface the limiter touches (header reads,
// get('request_id'), header() set, json()). Cast to AppContext for the call.
type Headers = Record<string, string | undefined>;

function makeCtx(headers: Headers = {}): {
  ctx: AppContext;
  responses: Array<{ body: unknown; status: number }>;
  setHeaders: Record<string, string>;
} {
  const responses: Array<{ body: unknown; status: number }> = [];
  const setHeaders: Record<string, string> = {};
  const lower: Headers = {};
  for (const [k, v] of Object.entries(headers)) lower[k.toLowerCase()] = v;

  const ctx = {
    req: { header: (name: string): string | undefined => lower[name.toLowerCase()] },
    get: (_k: string): string => 'req-id-test',
    header: (name: string, value: string): void => {
      setHeaders[name] = value;
    },
    json: (body: unknown, status: number): Response => {
      responses.push({ body, status });
      return new Response(JSON.stringify(body), { status });
    },
  } as unknown as AppContext;

  return { ctx, responses, setHeaders };
}

const passthrough = async (): Promise<void> => {};

describe('createRateLimiter (audit P2)', () => {
  test('allows up to max requests then returns 429 with Retry-After', async () => {
    const { middleware } = createRateLimiter({ name: 'auth', windowSeconds: 60, max: 3 });
    const ip = { 'cf-connecting-ip': '203.0.113.7' };

    for (let i = 0; i < 3; i++) {
      const { ctx, responses } = makeCtx(ip);
      const res = await middleware(ctx, passthrough);
      expect(res).toBeUndefined(); // passed through
      expect(responses.length).toBe(0);
    }

    // 4th request in the window is throttled.
    const { ctx, responses, setHeaders } = makeCtx(ip);
    const res = await middleware(ctx, passthrough);
    expect(res).toBeInstanceOf(Response);
    expect(res?.status).toBe(429);
    expect(responses[0]?.status).toBe(429);
    const body = responses[0]?.body as { error: { kind: string; code?: string } };
    expect(body.error.kind).toBe('rate_limited');
    expect(body.error.code).toBe('E_RATE_LIMITED_AUTH');
    expect(Number(setHeaders['Retry-After'])).toBeGreaterThan(0);
  });

  test('separate IPs get separate buckets', async () => {
    const { middleware } = createRateLimiter({ name: 'auth', windowSeconds: 60, max: 1 });

    const a = makeCtx({ 'cf-connecting-ip': '198.51.100.1' });
    const b = makeCtx({ 'cf-connecting-ip': '198.51.100.2' });

    expect(await middleware(a.ctx, passthrough)).toBeUndefined();
    expect(await middleware(b.ctx, passthrough)).toBeUndefined();

    // Second hit from A is throttled; B still independent.
    const a2 = makeCtx({ 'cf-connecting-ip': '198.51.100.1' });
    expect((await middleware(a2.ctx, passthrough))?.status).toBe(429);
  });

  test('window reset allows requests again', async () => {
    // 1-second window keeps the test fast.
    const { middleware } = createRateLimiter({ name: 'chat', windowSeconds: 1, max: 1 });
    const ip = { 'cf-connecting-ip': '192.0.2.50' };

    expect(await middleware(makeCtx(ip).ctx, passthrough)).toBeUndefined();
    expect((await middleware(makeCtx(ip).ctx, passthrough))?.status).toBe(429);

    await new Promise((r) => setTimeout(r, 1100));
    expect(await middleware(makeCtx(ip).ctx, passthrough)).toBeUndefined();
  });

  test('max=0 disables the limiter (always passes through)', async () => {
    const { middleware } = createRateLimiter({ name: 'auth', windowSeconds: 60, max: 0 });
    const ip = { 'cf-connecting-ip': '203.0.113.9' };
    for (let i = 0; i < 50; i++) {
      expect(await middleware(makeCtx(ip).ctx, passthrough)).toBeUndefined();
    }
  });

  test('reset() clears all buckets', async () => {
    const { middleware, reset } = createRateLimiter({ name: 'auth', windowSeconds: 60, max: 1 });
    const ip = { 'cf-connecting-ip': '203.0.113.11' };
    expect(await middleware(makeCtx(ip).ctx, passthrough)).toBeUndefined();
    expect((await middleware(makeCtx(ip).ctx, passthrough))?.status).toBe(429);
    reset();
    expect(await middleware(makeCtx(ip).ctx, passthrough)).toBeUndefined();
  });
});

describe('rate-limit helpers', () => {
  test('clientIpFromContext prefers cf-connecting-ip, then x-forwarded-for first hop', () => {
    expect(clientIpFromContext(makeCtx({ 'cf-connecting-ip': '1.1.1.1' }).ctx)).toBe('1.1.1.1');
    expect(
      clientIpFromContext(makeCtx({ 'x-forwarded-for': '2.2.2.2, 3.3.3.3' }).ctx),
    ).toBe('2.2.2.2');
    expect(clientIpFromContext(makeCtx({}).ctx)).toBe('unknown');
  });

  test('shortHash is deterministic and never returns the raw value', () => {
    expect(shortHash('abc')).toBe(shortHash('abc'));
    expect(shortHash('abc')).not.toBe('abc');
    expect(shortHash('abc')).toHaveLength(16);
  });
});
