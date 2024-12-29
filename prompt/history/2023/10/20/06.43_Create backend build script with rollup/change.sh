#!/bin/sh
set -e
goal="Create backend build script with rollup"
echo "Plan:"
echo "1. Create a rollup config in ./src/backend directory"
echo "2. Add the npm script build:backend to the package.json file"
echo "3. Ensure the rollup config uses the correct entry and output specifications"

# Dependencies to be excluded from rollup build
DEPS="@types/js-yaml,autoprefixer,chatgpt,cors,ejs,express,highlight.js,js-yaml,markdown-it,marked,node-pty,postcss,postcss-nested,sharp,simple-git,solid-js,tailwindcss,vite,vite-plugin-solid,ws,xterm"

# Step 1: Create rollup config
cat > ./src/backend/rollup.config.js << EOF
import { nodeResolve } from '@rollup/plugin-node-resolve';

const externalDependencies = '$DEPS'.split(',');

export default {
  input: './startServer.js',
  output: {
    dir: '../../dist/backend/',
    format: 'esm',
    sourcemap: true,
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    })
  ],
  external: externalDependencies
};
EOF

# Step 2: Add the npm script build:backend to the package.json file
jq '.scripts["build:backend"] = "cd src/backend && rollup --config rollup.config.js"' ./package.json > tmp.$$.json && mv tmp.$$.json ./package.json

echo "\033[32mDone: $goal\033[0m\n"