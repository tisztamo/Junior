#!/bin/sh
set -e
goal="Move and reconfigure Tailwind config file"
echo "Plan:"
echo "1. Move the 'tailwind.config.js' file to 'src/frontend' directory."
echo "2. Rename the 'tailwind.config.js' to 'tailwind.config.cjs' since Node.js uses commonJS and not ES6 syntax."
echo "3. Update 'postcss.config.cjs' in 'src/frontend' directory to use the moved tailwind config file with the complete path."
echo "4. Update 'vite.config.js' in 'src' directory to use the updated 'postcss.config.cjs' file."

# Move and rename the tailwind config file
mv ./tailwind.config.js ./src/frontend/tailwind.config.cjs

# Heredoc the new postcss.config.cjs file
cat <<'EOF' > ./src/frontend/postcss.config.cjs
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssImport = require('postcss-import');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'postcss-import': {},
    'tailwindcss/nesting': postcssNested,
    tailwindcss: { config: './src/frontend/tailwind.config.cjs' },
    autoprefixer: autoprefixer,
  },
};
EOF

# Heredoc the updated vite.config.js file
cat <<'EOF' > ./src/vite.config.js
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
EOF

echo "\033[32mDone: $goal\033[0m\n"
