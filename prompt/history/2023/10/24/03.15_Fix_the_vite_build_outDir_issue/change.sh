#!/bin/sh
set -e
goal="Fix the vite build outDir issue"
echo "Plan:"
echo "1. Modify the build:frontend script in package.json to add --emptyOutDir option."

# Using jq to modify the package.json to add --emptyOutDir option to the build:frontend script
jq '.scripts["build:frontend"] = "cd ./src/frontend/ && vite build --emptyOutDir"' package.json > package.tmp.json && mv package.tmp.json package.json

echo "\033[32mDone: $goal\033[0m\n"