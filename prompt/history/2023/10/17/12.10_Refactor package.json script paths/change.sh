#!/bin/sh
set -e
goal="Refactor package.json script paths"
echo "Plan:"
echo "1. Update the 'scripts' paths according to 'bin' values using jq"
echo "2. Overwrite the original package.json with the updated data"

# Use jq to modify the package.json
jq '
  .scripts.cli |= "node scripts/main.js" |
  .scripts.start |= "node scripts/web.js" |
  .scripts.rollback |= "node scripts/junior-rollback.js"
' ./package.json > ./temp_package.json && mv ./temp_package.json ./package.json

echo "\033[32mDone: $goal\033[0m\n"