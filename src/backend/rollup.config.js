import { nodeResolve } from '@rollup/plugin-node-resolve';

const externalDependencies = '@types/js-yaml,autoprefixer,chatgpt,cors,ejs,express,highlight.js,js-yaml,markdown-it,marked,node-pty,postcss,postcss-nested,sharp,simple-git,solid-js,tailwindcss,vite,vite-plugin-solid,ws,xterm'.split(',');

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
  external: externalDependencies
};
