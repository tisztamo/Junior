import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: join(__dirname, 'postcss.config.cjs'),
  },
  build: {
    target: 'esnext',
  },
})
