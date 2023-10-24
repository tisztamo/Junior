#!/bin/sh
set -e
goal="Update Rollup config for external deps"
echo "Plan:"
echo "1. Modify rollup.config.js to use RegExp for node_modules."
cat > ./src/backend/rollup.config.js << 'EOF'
import { nodeResolve } from '@rollup/plugin-node-resolve';

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
  external: [/node_modules/]
};

EOF
echo "\033[32mDone: $goal\033[0m\n"