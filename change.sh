#!/bin/sh
# Goal: Integrate tailwindcss with PostCSS in project
# Plan:
# 1. Install tailwindcss, postcss, autoprefixer using npm.
# 2. Create a new file 'postcss.config.js' at the root of the project with the required configurations for tailwindcss, postcss, and autoprefixer.
# 3. Update 'package.json' to include a new script to build css.
# 4. Create a new 'styles.css' file under 'src/frontend' where tailwindcss classes will be used.
# 5. Update 'index.jsx' to import 'styles.css'.

# Step 1: Install necessary dependencies
npm install -D tailwindcss postcss autoprefixer

# Step 2: Create 'postcss.config.js' with necessary configurations
cat >./postcss.config.js <<EOF
import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';

export default function postCssConfig() {
  return {
    plugins: [
      tailwindcss(),
      autoprefixer()
    ]
  }
}
EOF

# Step 3: Update 'package.json' to include a new script to build css
jq '.scripts += {"build:css": "postcss ./src/frontend/styles.css -o ./dist/styles.css"}' package.json > package.json.tmp && mv package.json.tmp package.json

# Step 4: Create a 'styles.css' file under 'src/frontend' to use tailwindcss classes
cat >./src/frontend/styles.css <<EOF
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';
EOF

# Step 5: Update 'index.jsx' to import 'styles.css'
echo 'import "./styles.css";' | cat - ./src/frontend/index.jsx > temp && mv temp ./src/frontend/index.jsx

# End of Script
