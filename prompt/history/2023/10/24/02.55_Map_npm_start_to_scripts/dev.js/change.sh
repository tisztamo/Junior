#!/bin/sh
set -e
goal="Map npm start to scripts/dev.js"
echo "Plan:"
echo "1. Modify the package.json to change the script associated with 'npm start'."
echo "2. Make scripts/dev.js executable."

# Modify the package.json to change the script associated with 'npm start'.
jq '.scripts.start = "node scripts/dev.js"' package.json > temp.json && mv temp.json package.json

# Make scripts/dev.js executable.
chmod +x scripts/dev.js

echo "\033[32mDone: $goal\033[0m\n"
