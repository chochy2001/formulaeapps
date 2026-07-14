import { describe, test, expect } from 'bun:test';
import { iapRateLimitKey } from '../../src/middleware/limiters';
import { createRateLimiter, clientIpFromContext, shortHash } from '../../src/middleware/rate-limit';
import type { AppContext } from '../../src/lib/openapi';

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

describe('createRateLimiter: custom keyFn with JWT sub', () => {
  test('keyFn that includes sub creates separate buckets', async () => {
    const { middleware } = createRateLimiter({
      name: 'chat',
      windowSeconds: 60,
      max: 1,
      keyFn: (c: AppContext) => {
        const ip = clientIpFromContext(c);
        const sub = c.get('jwt_claims')?.sub;
        return sub ? `${ip}|${shortHash(sub)}` : ip;
      },
    });

    const ctx1 = makeCtx({ 'cf-connecting-ip': '1.2.3.4' });
    // Simulate JWT claims attached by jwt-auth middleware
    (ctx1.ctx as any).get = (k: string) => {
      if (k === 'jwt_claims') return { sub: 'user-a' };
      return 'req-id';
    };

    const ctx2 = makeCtx({ 'cf-connecting-ip': '1.2.3.4' });
    (ctx2.ctx as any).get = (k: string) => {
      if (k === 'jwt_claims') return { sub: 'user-b' };
      return 'req-id';
    };

    // Same IP, different sub → separate buckets
    expect(await middleware(ctx1.ctx, passthrough)).toBeUndefined();
    expect(await middleware(ctx2.ctx, passthrough)).toBeUndefined();

    // Second hit from user-a is throttled
    const ctx1b = makeCtx({ 'cf-connecting-ip': '1.2.3.4' });
    (ctx1b.ctx as any).get = (k: string) => {
      if (k === 'jwt_claims') return { sub: 'user-a' };
      return 'req-id';
    };
    expect((await middleware(ctx1b.ctx, passthrough))?.status).toBe(429);
  });

  test('custom keyFn that uses a simple property for bucket isolation', async () => {
    const { middleware } = createRateLimiter({
      name: 'custom',
      windowSeconds: 60,
      max: 1,
      keyFn: (_c: AppContext) => 'static-key',
    });

    const a = makeCtx({ 'cf-connecting-ip': '1.1.1.1' });
    const b = makeCtx({ 'cf-connecting-ip': '2.2.2.2' });

    // Same key → both hit the same bucket
    expect(await middleware(a.ctx, passthrough)).toBeUndefined();
    expect((await middleware(b.ctx, passthrough))?.status).toBe(429);
  });

  test('shortHash and clientIpFromContext are composable', () => {
    const ip = clientIpFromContext(makeCtx({ 'cf-connecting-ip': '9.9.9.9' }).ctx);
    const hash = shortHash('user-x');
    const composite = `${ip}|${hash}`;
    expect(composite).toBe('9.9.9.9|' + hash);
    expect(composite).not.toContain('user-x');
  });
});

describe('iapRateLimitKey', () => {
  test('hashes the authenticated subject and forwarded IP without retaining PII', () => {
    const { ctx } = makeCtx({ 'cf-connecting-ip': '203.0.113.51' });
    (ctx as any).get = (key: string) => {
      if (key === 'jwt_claims') return { sub: 'stable-subject-identifier' };
      return 'req-id';
    };

    const key = iapRateLimitKey(ctx);

    expect(key).toHaveLength(16);
    expect(key).toMatch(/^[a-f0-9]+$/);
    expect(key).not.toContain('203.0.113.51');
    expect(key).not.toContain('stable-subject-identifier');
  });
});
