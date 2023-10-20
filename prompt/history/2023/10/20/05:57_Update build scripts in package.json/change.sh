#!/bin/sh
set -e
goal="Update build scripts in package.json"
echo "Plan:"
echo "1. Remove the build:css script from package.json"
echo "2. Add the build:frontend script to package.json that triggers vite build in ./src/frontend/ directory"

# Using jq to manipulate JSON (package.json) to achieve our goals
jq 'del(.scripts["build:css"])' ./package.json > ./temp.json && mv ./temp.json ./package.json
jq '.scripts["build:frontend"] = "cd ./src/frontend/ && vite build"' ./package.json > ./temp.json && mv ./temp.json ./package.json

echo "\033[32mDone: $goal\033[0m\n"
