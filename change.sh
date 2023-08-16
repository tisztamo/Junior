#!/bin/sh
set -e
goal="Add host warning to startVite"
echo "Plan:"
echo "1. Modify startVite.js to add the orange warning when hostArgPresent is true."

cat << 'EOF' > src/frontend/startVite.js
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import process from 'process';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const hostArgPresent = process.argv.includes('--host');

  if (hostArgPresent) {
    console.warn('\x1b[33m%s\x1b[0m', 'This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn.');
  }

  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
      ...(hostArgPresent ? { host: true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"