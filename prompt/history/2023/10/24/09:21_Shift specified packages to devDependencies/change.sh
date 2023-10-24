#!/bin/sh
set -e
goal="Shift specified packages to devDependencies"
echo "Plan:"
echo "1. Modify package.json to move vite, postcss, and rollup-related packages from dependencies to devDependencies."

# Use jq to modify the package.json
jq '.devDependencies += { "@rollup/plugin-node-resolve": .dependencies["@rollup/plugin-node-resolve"], "postcss": .dependencies["postcss"], "postcss-nested": .dependencies["postcss-nested"], "vite": .dependencies["vite"], "vite-plugin-solid": .dependencies["vite-plugin-solid"] } | del(.dependencies["@rollup/plugin-node-resolve"], .dependencies["postcss"], .dependencies["postcss-nested"], .dependencies["vite"], .dependencies["vite-plugin-solid"])' package.json > temp.json && mv temp.json package.json

echo "\033[32mDone: $goal\033[0m\n"
