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

