#!/bin/sh
set -e
goal="Fix postcss config and remove unused imports"
echo "Plan:"
echo "1. Remove unused imports from postcss.config.cjs"
echo "2. Calculate the relative path using dirname and use it for tailwindcss config path"

cat >./src/frontend/postcss.config.cjs <<'EOF'
const path = require('path');
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'tailwindcss/nesting': postcssNested,
    tailwindcss: { config: path.join(__dirname, 'tailwind.config.cjs') },
    autoprefixer: autoprefixer,
  },
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
