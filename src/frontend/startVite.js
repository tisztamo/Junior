import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import hostConfig from '../config/hostConfig.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const { enabled, ip } = hostConfig();

  if (enabled) {
    console.warn('\x1b[33m%s\x1b[0m', 'This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn.');
  }

  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
      ...(enabled ? { host: ip || true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}
