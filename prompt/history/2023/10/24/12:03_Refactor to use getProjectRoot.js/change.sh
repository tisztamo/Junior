#!/bin/sh
set -e
goal="Refactor to use getProjectRoot.js"
echo "Plan:"
echo "1. Refactor startVite.js to use getProjectRoot for calculating the project root."
echo "2. Refactor vite.config.js to use getProjectRoot for path-related operations."
echo "3. Refactor listTasks.js to determine tasksDir using getProjectRoot."

# 1. Refactor startVite.js
cat > ./src/frontend/startVite.js << 'EOF'
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
EOF

# 2. Refactor vite.config.js
cat > ./src/frontend/vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import { join } from 'path'
import getProjectRoot from '../backend/fileutils/getProjectRoot.js'

const projectRoot = getProjectRoot();

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: join(projectRoot, 'src/frontend/postcss.config.cjs'),
  },
  build: {
    target: 'esnext',
    outDir: join(projectRoot, 'dist/frontend')
  },
})
EOF

# 3. Refactor listTasks.js
cat > ./src/backend/handlers/listTasks.js << 'EOF'
import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';
import { readDirRecursively } from '../fileutils/readDirRecursively.js';

export const listTasks = () => {
    const projectRoot = getProjectRoot();
    const tasksDir = path.join(projectRoot, 'prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
