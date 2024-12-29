#!/bin/sh
set -e
goal="Configure frontend port akin to backend"
echo "Plan:"
echo "1. Create a getFrontendPort function analogous to getServerPort for the frontend."
echo "2. Modify startVite.js to utilize the getFrontendPort function."

# Construct getFrontendPort function
cat > ./src/frontend/getFrontendPort.js << 'EOF'
function getFrontendPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--frontend-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_FRONTEND_PORT || 5864;
}

export default getFrontendPort;
EOF

# Revise startVite.js to employ the getFrontendPort function
cat > ./src/frontend/startVite.js << 'EOF'
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import hostConfig from '../config/hostConfig.js';
import getFrontendPort from './getFrontendPort.js';

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
      port: getFrontendPort(),
      ...(enabled ? { host: ip || true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"