#!/bin/sh
set -e
goal="Install docsify-cli and reorganize documentation"
echo "Plan:"
echo "1. Install docsify-cli locally using npm"
echo "2. Run docsify init in the new ./docs directory"
echo "3. Move markdown and png files and assets directory from doc to docs"
echo "4. Remove the doc/ directory"
echo "5. Remove the docs build command from package.json"

# Step 1: Install docsify-cli locally using npm
npm install docsify-cli --save-dev

# Step 2: Run docsify init in the new ./docs directory
npx docsify init ./docs

# Step 3: Move markdown and png files and assets directory from doc to docs
mv ./doc/*.md ./docs
mv ./doc/*.png ./docs
mv ./doc/assets ./docs

# Step 4: Remove the doc/ directory
rm -rf ./doc

# Step 5: Remove the docs build command from package.json
# Instead of using sed or similar tools, we write the whole package.json with the required changes
cat > package.json <<- 'EOF'
{
  "name": "@aijunior/dev",
  "version": "0.1.1",
  "description": "Your AI Contributor which codes itself",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "src/main.js",
    "junior-web": "src/web.js",
    "junior-init": "src/init.js"
  },
  "scripts": {
    "cli": "node src/main.js",
    "start": "node src/web.js",
    "build:css": "postcss ./src/frontend/styles.css -o ./dist/styles.css"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
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
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.3",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0",
    "ws": "^8.13.0",
    "docsify-cli": "^4.4.7"
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
  "homepage": "https://github.com/tisztamo/Junior#readme"
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
