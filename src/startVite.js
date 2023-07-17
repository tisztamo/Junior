import { exec } from 'child_process';

export function startVite() {
  const vite = exec('vite src --open');
  vite.stdout.pipe(process.stdout);
  vite.stderr.pipe(process.stderr);

  process.on('exit', () => vite.kill());
}
