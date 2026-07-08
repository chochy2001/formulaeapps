import { describe, test, expect } from 'bun:test';
import { jwtAuthMiddleware } from '../../src/middleware/jwt-auth';
import type { AppContext } from '../../src/lib/openapi';

function makeCtx(authHeader: string | undefined): AppContext {
  const headers: Record<string, string> = {};
  if (authHeader !== undefined) headers['authorization'] = authHeader;

  return {
    req: {
      header: (name: string): string | undefined =>
        headers[name.toLowerCase()],
    },
    get: (_k: string): string => 'req-id',
    set: () => {},
    header: () => {},
    json: (body: unknown, status: number): Response =>
      new Response(JSON.stringify(body), { status }),
    newResponse: (): Response => new Response(),
    body: null,
    status: 200,
    res: undefined as unknown as Response,
    var: undefined as unknown as Record<string, unknown>,
    event: undefined as unknown as any,
    executionCtx: undefined as unknown as any,
    render: (() => {}) as any,
    notFound: (() => {}) as any,
    redirect: (() => {}) as any,
    resHeaders: new Headers(),
  } as unknown as AppContext;
}

const passthrough = async (): Promise<void> => {};

describe('jwtAuthMiddleware: empty bearer token', () => {
  test('Bearer with only whitespace after prefix returns 401 E_EMPTY_JWT', async () => {
    const ctx = makeCtx('Bearer ');
    const result = await jwtAuthMiddleware(ctx, passthrough);
    expect(result).toBeInstanceOf(Response);
    const body = (await (result as Response).json()) as { error: { code?: string } };
    expect(body.error.code).toBe('E_EMPTY_JWT');
  });

  test('missing Authorization header returns 401 E_MISSING_JWT', async () => {
    const ctx = makeCtx(undefined);
    const result = await jwtAuthMiddleware(ctx, passthrough);
    expect(result).toBeInstanceOf(Response);
    const body = (await (result as Response).json()) as { error: { code?: string } };
    expect(body.error.code).toBe('E_MISSING_JWT');
  });
});
