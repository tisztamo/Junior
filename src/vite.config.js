import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: './src/frontend/postcss.config.cjs'
  },
  build: {
    target: 'esnext',
  },
})
