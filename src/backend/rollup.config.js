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
