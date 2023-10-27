import { argv } from 'process';

export function isDebug() {
  const hasDebugArg = argv.includes('--debug');
  const hasDebugEnv = process.env.JUNIOR_DEBUG === 'true';
  return hasDebugArg || hasDebugEnv;
}
