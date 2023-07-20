#!/bin/sh
# Goal: Fix Nested CSS Detection Issue with Vite and Tailwind CSS
# Plan:
# 1. Install postcss-nested package using npm
# 2. Modify postcss.config.js file to include postcss-nested before tailwindcss

# Step 1: Install postcss-nested package using npm
npm install postcss-nested

# Step 2: Modify postcss.config.js
cat << EOF > ./postcss.config.js
import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';
import postcssNested from 'postcss-nested';

export default function postCssConfig() {
  return {
    plugins: [
      postcssNested(),
      tailwindcss(),
      autoprefixer()
    ]
  }
}
EOF
