#!/bin/sh
# Goal: Optimize Tailwind CSS v3.0 configuration
# Plan:
# 1. The `content` option should include only relevant source files to optimize the build process.
# 2. Update the `content` paths in the tailwind.config.js file to include only the `src` directory.

cat << 'EOF' > tailwind.config.js
export default {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.tsx', './src/**/*.ts'],
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
EOF

echo "Tailwind CSS configuration has been optimized for faster builds. The content option now includes only the source files in the 'src' directory."
