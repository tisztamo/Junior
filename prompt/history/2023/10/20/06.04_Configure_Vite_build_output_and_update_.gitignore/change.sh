#!/bin/sh
set -e
goal="Configure Vite build output and update .gitignore"
echo "Plan:"
echo "1. Update vite.config.js to set the output directory for the build to ./dist/frontend/"
echo "2. Update .gitignore to ignore the dist/ directory"

# Step 1: Update vite.config.js
cat > ./src/frontend/vite.config.js << 'EOF'
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
    outDir: join(__dirname, '../../dist/frontend')
  },
})
EOF

# Step 2: Update .gitignore
cat > ./.gitignore << 'EOF'
/secret.sh
/node_modules/
/tmp/
/prompt.yaml
/prompt.md
/change.sh

node_modules

# Backup patterns for .md files
*.md.backup
*.md.bak
*_backup.md
*.md~
*.md.tmp
*.md.old
*.md.orig
*.md.save

# Ignoring build output directory
/dist/
EOF

echo "\033[32mDone: $goal\033[0m\n"