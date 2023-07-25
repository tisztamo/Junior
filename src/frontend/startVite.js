import { exec } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export function startVite() {
  const vite = exec(`${projectRoot}/node_modules/.bin/vite ${projectRoot}/src/frontend --open`);
  vite.stdout.pipe(process.stdout);
  vite.stderr.pipe(process.stderr);

  process.on('exit', () => vite.kill());
}
