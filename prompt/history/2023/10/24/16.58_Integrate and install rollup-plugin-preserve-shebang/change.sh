#!/bin/sh
set -e
goal="Integrate and install rollup-plugin-preserve-shebang"
echo "Plan:"
echo "1. Install rollup-plugin-preserve-shebang using npm."
echo "2. Modify rollup.config.js to import and use the rollup-plugin-preserve-shebang plugin."

# Installing rollup-plugin-preserve-shebang
npm install rollup-plugin-preserve-shebang --save-dev

# Modifying rollup.config.js
cat > ./src/backend/rollup.config.js << 'EOF'
import { nodeResolve } from '@rollup/plugin-node-resolve';
import shebang from 'rollup-plugin-preserve-shebang';

const BIN_PATH = '../../bin/';
const DIST_PATH = '../../dist/';

const commonConfig = {
  output: {
    format: 'esm'
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    }),
    shebang()
  ],
  external: [/node_modules/]
};

export default [
  {
    ...commonConfig,
    input: './startServer.js',
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}backend/`
    }
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}init.js`,
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}rollback.js`,
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}web.js`,
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  }
];
EOF

echo "\033[32mDone: $goal\033[0m\n"