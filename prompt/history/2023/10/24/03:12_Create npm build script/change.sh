#!/bin/sh
set -e
goal="Create npm build script"
echo "Plan:"
echo "1. Update package.json to add a new 'build' script that combines build:frontend and build:backend"

# Update the package.json to add the new build script
jq '.scripts.build = "npm run build:frontend && npm run build:backend"' ./package.json > ./package_temp.json && mv ./package_temp.json ./package.json

echo "\033[32mDone: $goal\033[0m\n"