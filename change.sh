#!/bin/sh
set -e
goal="Move convert-svg-to-png.cjs, create npm run command"
echo "Plan:"
echo "1. Move convert-svg-to-png.cjs to ./scripts directory"
echo "2. Update package.json with a new npm run command for logo updating workflow"

# Create the scripts directory if it doesn't exist
mkdir -p ./scripts

# Move convert-svg-to-png.cjs to the new location
mv convert-svg-to-png.cjs ./scripts/convert-svg-to-png.cjs

# Add a new npm run command to the package.json file
jq '.scripts += {"update-logo": "node ./scripts/convert-svg-to-png.cjs"}' package.json > package.tmp.json
mv package.tmp.json package.json

echo "\033[32mDone: $goal\033[0m\n"
