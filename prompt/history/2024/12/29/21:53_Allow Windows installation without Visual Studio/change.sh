#!/bin/sh
set -e
goal="Allow Windows installation without Visual Studio"
echo "Plan:"
echo "1. Modify package.json to use prebuilt binaries for node-pty."
echo "2. Ensure node-pty is fetched with prebuilt binaries on Windows."
echo "3. Create a postinstall script to verify the prebuilt binaries are used."

# Modify package.json to use node-pty with prebuilt binaries
cat > package.json << 'EOF'
{
  "name": "@aijunior/dev",
  "version": "0.3.21",
  "description": "Your AI Contributor which codes itself",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "dist/bin/web.js",
    "junior-web": "dist/bin/web.js",
    "junior-cli": "dist/bin/cli.js",
    "junior-init": "dist/bin/init.js",
    "junior-rollback": "dist/bin/rollback.js",
    "junior-news": "dist/bin/readGitHistoryToMd.js"
  },
  "scripts": {
    "cli": "node scripts/cli.js",
    "start": "node scripts/dev.js",
    "update-logo": "node ./scripts/updateLogo.js",
    "clear-branches": "node ./scripts/clearBranchesCommand.js $@",
    "test": "cypress open",
    "rollback": "node scripts/junior-rollback.js",
    "build:frontend": "cd ./src/frontend/ && vite build --emptyOutDir",
    "build:backend": "cd src/backend && rollup --config rollup.config.js",
    "dev": "npm run start",
    "build": "npm run build:frontend && npm run build:backend",
    "postinstall": "node scripts/postinstall.js"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "MIT",
  "dependencies": {
    "@types/js-yaml": "^4.0.5",
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "cors": "^2.8.5",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "highlight.js": "^11.8.0",
    "js-yaml": "^4.1.0",
    "markdown-it": "^13.0.1",
    "marked": "^5.1.0",
    "node-pty-prebuilt-multiarch": "^0.10.1",
    "sanitize-filename": "^1.6.3",
    "sharp": "^0.32.4",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.3",
    "ws": "^8.13.0",
    "xterm": "^5.3.0"
  },
  "directories": {
    "doc": "docs"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  },
  "bugs": {
    "url": "https://github.com/tisztamo/Junior/issues"
  },
  "homepage": "https://github.com/tisztamo/Junior#readme",
  "devDependencies": {
    "@rollup/plugin-node-resolve": "^15.2.3",
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "rollup-plugin-preserve-shebang": "^1.0.1",
    "vite": "^4",
    "vite-plugin-solid": "^2"
  },
  "files": [
    "dist/",
    "prompt/",
    "scripts/"
  ]
}
EOF

# Create a postinstall script to validate prebuilt binaries
mkdir -p scripts
cat > scripts/postinstall.js << 'EOF'
import { execSync } from 'child_process';

async function validatePrebuiltBinary() {
  try {
    console.log('Validating prebuilt binaries for node-pty...');
    execSync('node -e "require(\'node-pty-prebuilt-multiarch\')"', { stdio: 'inherit' });
    console.log('Validation successful.');
  } catch (error) {
    console.error('Validation failed. Please check your setup.');
    process.exit(1);
  }
}

validatePrebuiltBinary();
EOF

chmod +x scripts/postinstall.js

echo "\033[32mDone: $goal\033[0m\n"
