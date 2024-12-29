#!/bin/sh
set -e
goal="Update rollup config and package.json paths"
echo "Plan:"
echo "1. Update package.json bin commands to refer to dist/bin/"
echo "2. Add web.js to rollup configuration for processing"
echo "3. Factor out repeated paths in rollup.config.js to constants"

# 1. Update package.json bin commands to refer to dist/bin/
jq '.bin |=
    {
        "junior": "dist/bin/web.js",
        "junior-web": "dist/bin/web.js",
        "junior-cli": "dist/bin/cli.js",
        "junior-init": "dist/bin/init.js",
        "junior-rollback": "dist/bin/junior-rollback.js",
        "junior-news": "dist/bin/readGitHistoryToMd.js"
    }' ./package.json > ./package.temp.json && mv ./package.temp.json ./package.json

# 2. Add web.js to rollup configuration for processing
# 3. Factor out repeated paths in rollup.config.js to constants
cat > ./src/backend/rollup.config.js << 'EOF'
import { nodeResolve } from '@rollup/plugin-node-resolve';

const BIN_PATH = '../../bin/';
const DIST_PATH = '../../dist/';

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