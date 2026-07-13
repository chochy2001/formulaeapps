/**
 * Runtime feature flags for BFF account / entitlement work (fleet #86).
 *
 * Read from process.env at call time (not import-time env.ts) so unit tests
 * can toggle without reloading the module graph. All defaults are OFF.
 */

/** Email/password account routes + user_id entitlement binding. Default off. */
export function isUserAccountAuthEnabled(): boolean {
  return process.env['ENABLE_USER_ACCOUNT_AUTH'] === 'true';
}
