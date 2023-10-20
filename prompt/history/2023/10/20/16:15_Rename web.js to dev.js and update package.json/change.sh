#!/bin/sh
set -e

goal="Rename web.js to dev.js and update package.json"
echo "Plan:"
echo "1. Rename web.js to dev.js"
echo "2. Update references in package.json to use dev.js instead of web.js"
echo "3. Add a new npm script named 'dev' to run the dev.js script"

# 1. Rename web.js to dev.js
mv ./scripts/web.js ./scripts/dev.js

# 2. Update references in package.json
jq '.bin["junior-web"] = "scripts/dev.js" | .scripts["start"] = "node scripts/dev.js" | .scripts["dev"] = "npm run start"' package.json > package_temp.json && mv package_temp.json package.json

echo "\033[32mDone: $goal\033[0m\n"