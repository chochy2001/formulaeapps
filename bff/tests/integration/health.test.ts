import { describe, test, expect } from 'bun:test';
import { app } from '../../src/index';

describe('integration: GET /health', () => {
  test('returns 200 with HealthResponse shape', async () => {
    const res = await app.request('/health');
    expect(res.status).toBe(200);
    const body = (await res.json()) as {
      status: string;
      version: string;
      prompts_version: string;
      uptime_seconds: number;
    };
    expect(body.status).toBe('ok');
    expect(body.version).toBeTypeOf('string');
    expect(body.prompts_version).toBeTypeOf('string');
    expect(body.uptime_seconds).toBeGreaterThanOrEqual(0);
  });

  test('sets X-Request-Id header on every response', async () => {
    const res = await app.request('/health');
    const requestId = res.headers.get('x-request-id');
    expect(requestId).toBeTruthy();
    expect(requestId).toMatch(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i);
  });

  test('emits OpenAPI document at /openapi.json', async () => {
    const res = await app.request('/openapi.json');
    expect(res.status).toBe(200);
    const doc = (await res.json()) as { openapi: string; info: { title: string }; paths: Record<string, unknown> };
    expect(doc.openapi).toBe('3.1.0');
    expect(doc.info.title).toBe('FormulaeApps BFF');
    expect(doc.paths['/health']).toBeDefined();
    expect(doc.paths['/auth/token']).toBeDefined();
    expect(doc.paths['/openai/chat']).toBeDefined();
    expect(doc.paths['/iap/validate']).toBeDefined();
    expect(doc.paths['/entitlement']).toBeDefined();
  });
});
