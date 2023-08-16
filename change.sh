#!/bin/sh
set -e
goal="Set host based on CLI arg"
echo "Plan:"
echo "1. Extract CLI arguments directly in 'startVite.js'."
echo "2. Set the 'host' config based on the --host CLI argument."

# Modifying the 'startVite.js' file to extract CLI arguments directly and set 'host' config
cat <<EOF > src/frontend/startVite.js
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import process from 'process';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const hostArgPresent = process.argv.includes('--host');

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
