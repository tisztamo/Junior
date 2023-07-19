#!/bin/sh
# Goal: Fix TypeScript error for js-yaml module
# Plan:
# 1. Install @types/js-yaml using npm
# 2. If @types/js-yaml doesn't exist, create a declaration file (js-yaml.d.ts) 

npm install --save-dev @types/js-yaml

# Check if @types/js-yaml exists or not
if [ ! -d "./node_modules/@types/js-yaml" ]
then
  # @types/js-yaml does not exist, so create a declaration file
  cat > ./src/js-yaml.d.ts << 'EOF'
declare module 'js-yaml';
EOF
fi
