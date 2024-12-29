#!/bin/sh
set -e
goal="Make rolled-up bin commands executable"
echo "Plan:"
echo "1. Create a directory 'build' under 'src/backend/' for the custom rollup plugin."
echo "2. Construct a rollup plugin employing the 'writeBundle' hook and Node.js APIs for file permissions."
echo "3. Update rollup configuration to trigger the new plugin for making bin outputs executable."

# Create build directory under src/backend
mkdir -p src/backend/build

# Create the rollup plugin inside src/backend/build
cat > src/backend/build/makeExecutableRollupPlugin.js << 'EOF'
import { promises as fs } from 'fs';
import { dirname } from 'path';

export function makeExecutableRollupPlugin() {
  return {
    name: 'make-executable',
    async writeBundle(outputOptions, bundle) {
      for (let fileName of Object.keys(bundle)) {
        if (fileName.endsWith('.js')) {
          const filePath = `${outputOptions.dir}${fileName}`;
          const directoryName = dirname(filePath).split('/').pop();
          if (directoryName === 'bin') {
            // Make the file executable: 0o755 corresponds to rwxr-xr-x
            await fs.chmod(filePath, 0o755);
          }
        }
      }
    }
  };
}
EOF

# Update the rollup.config.js in src/backend
cat > src/backend/rollup.config.js << 'EOF'
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
  }
];
EOF

echo "\033[32mDone: $goal\033[0m\n"