#!/bin/sh
set -e
goal="Fix junior-rollback command in package.json"
echo "Plan:"
echo "1. Update junior-rollback command in package.json to point to bin/rollback.js."

# Extract the existing 'junior-rollback' path and replace with correct path using jq
new_path=$(jq '.bin["junior-rollback"] = "bin/rollback.js"' ./package.json)

# Write back the updated package.json
cat > package.json << EOF
$new_path
EOF

echo "\033[32mDone: $goal\033[0m\n"