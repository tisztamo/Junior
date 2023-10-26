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
