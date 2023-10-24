import { createServer } from 'vite';
import hostConfig from '../config/hostConfig.js';
import getFrontendPort from './getFrontendPort.js';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';

const projectRoot = getProjectRoot();

export async function startVite() {
  const { enabled, ip } = hostConfig();

  if (enabled) {
    console.warn('\x1b[33m%s\x1b[0m', 'This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn.');
  }

  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
      port: getFrontendPort(),
      ...(enabled ? { host: ip || true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}
