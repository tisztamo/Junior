#!/bin/sh
set -e
goal="Refactor package.json as per the task description"
echo "Plan:"
echo "1. Uninstall babel-preset-solid"
echo "2. Move every other item from devDependencies to dependencies"
echo "3. Set the description to 'Your AI Contributor which codes itself'"

# 1. Uninstall babel-preset-solid
npm uninstall babel-preset-solid

# 2. Move every other item from devDependencies to dependencies and 3. Set the description
jq '.description = "Your AI Contributor which codes itself" | .dependencies += .devDependencies | del(.devDependencies["@types/js-yaml"]) | del(.devDependencies["babel-preset-solid"]) | del(.devDependencies)' package.json > temp.json
mv temp.json package.json

echo "\033[32mDone: $goal\033[0m\n"
