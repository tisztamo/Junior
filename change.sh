#!/bin/sh
set -e
goal="Rewrite startVite to use Vite's JS API"
echo "Plan:"
echo "1. Modify src/frontend/startVite.js to use the Vite JS API."
echo "2. Ensure to open the browser and start from the directory found in the current version of startVite.js."

cat << 'EOF' > src/frontend/startVite.js
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
    },
  });
  await server.listen();
  server.printUrls();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
