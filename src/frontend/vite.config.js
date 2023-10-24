import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import { join } from 'path'
import getProjectRoot from '../backend/fileutils/getProjectRoot.js'

const projectRoot = getProjectRoot();

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: join(projectRoot, 'src/frontend/postcss.config.cjs'),
  },
  build: {
    target: 'esnext',
    outDir: join(projectRoot, 'dist/frontend')
  },
})
