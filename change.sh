#!/bin/sh
set -e
goal="Fix CSS nesting issue in postcss config"
echo "Plan:"
echo "1. Rename postcss.config.js to postcss.config.cjs"
echo "2. Modify the postcss config to include 'postcss-import', 'tailwindcss/nesting' before 'tailwindcss' and 'autoprefixer'"

mv postcss.config.js postcss.config.cjs

cat > postcss.config.cjs <<'EOF'
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssImport = require('postcss-import');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'postcss-import': {},
    'tailwindcss/nesting': postcssNested,
    tailwindcss: tailwindcss,
    autoprefixer: autoprefixer,
  },
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
