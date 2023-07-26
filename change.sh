#!/bin/sh
set -e
goal="Fix relative path issue in vite config"
echo "Plan:"
echo "1. Import { dirname } from 'path' and 'url' to create a dirname variable in the ES6 module context."
echo "2. Change the path for PostCSS configuration in vite.config.js to be relative to the vite.config.js file location using the dirname variable."

cat >./src/frontend/vite.config.js <<'EOF'
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: join(__dirname, 'postcss.config.cjs'),
  },
  build: {
    target: 'esnext',
  },
})
EOF

echo "\033[32mDone: $goal\033[0m\n"
