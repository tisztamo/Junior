#!/bin/sh
set -e
goal="Auto-execute cli.js and integrate with Rollup"
echo "Plan:"
echo "1. Modify cli.js to auto-execute its main function."
echo "2. Update rollup.config.js to include cli.js in the build."

# Ensure the script is executed in the correct directory
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR"

# Modify cli.js
cat > ./bin/cli.js << 'EOF'
#!/usr/bin/env node

import { startInteractiveSession } from '../src/interactiveSession/startInteractiveSession.js';
import { getApi, get_model, rl } from '../src/config.js';

(async () => {
  console.log("Welcome to Junior. Model: " + get_model() + "\\n");
  const api = await getApi();
  startInteractiveSession(rl, api);
})();
EOF
echo "Modified cli.js"

# Update rollup.config.js
cat > ./src/backend/rollup.config.js << 'EOF'
import { nodeResolve } from '@rollup/plugin-node-resolve';
import shebang from 'rollup-plugin-preserve-shebang';
import { makeExecutableRollupPlugin } from './build/makeExecutableRollupPlugin.js';

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
    shebang(),
    makeExecutableRollupPlugin()
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
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}cli.js`, // Include cli.js in Rollup build
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  }
];
EOF
echo "Updated rollup.config.js"

echo "\033[32mDone: $goal\033[0m\n"