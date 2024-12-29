#!/bin/sh
set -e

goal="Refactor files and update rollup config"
echo "Plan:"
echo "1. Rename junior-rollback.js to rollback.js"
echo "2. Update rollup config for new paths and additions"

# Rename junior-rollback.js to rollback.js
mv ./bin/junior-rollback.js ./bin/rollback.js

# Update rollup.config.js with new input paths and new entry for rollback.js
cat > ./src/backend/rollup.config.js << 'EOF'
import { nodeResolve } from '@rollup/plugin-node-resolve';

const commonConfig = {
  output: {
    format: 'esm'
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    })
  ],
  external: [/node_modules/]
};

export default [
  {
    ...commonConfig,
    input: './startServer.js',
    output: {
      ...commonConfig.output,
      dir: '../../dist/backend/'
    }
  },
  {
    ...commonConfig,
    input: '../../bin/init.js',
    output: {
      ...commonConfig.output,
      dir: '../../dist/bin/'
    }
  },
  {
    ...commonConfig,
    input: '../../bin/rollback.js',
    output: {
      ...commonConfig.output,
      dir: '../../dist/bin/'
    }
  }
];
EOF

echo "\033[32mDone: $goal\033[0m\n"