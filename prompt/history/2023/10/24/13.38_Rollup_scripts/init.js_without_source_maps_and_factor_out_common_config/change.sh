#!/bin/sh
set -e
goal="Rollup scripts/init.js without source maps and factor out common config"
echo "Plan:"
echo "1. Modify rollup.config.js to support multiple input files and factor out common config."

# Step 1: Modify rollup.config.js
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
    input: '../../scripts/init.js',
    output: {
      ...commonConfig.output,
      dir: '../../dist/scripts/'
    }
  }
];
EOF

echo "\033[32mDone: $goal\033[0m\n"