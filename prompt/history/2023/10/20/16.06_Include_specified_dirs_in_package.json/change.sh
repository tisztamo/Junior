#!/bin/sh
set -e
goal="Include specified dirs in package.json"
echo "Plan:"
echo "1. Update the package.json to include 'files' field."
echo "2. Set the 'files' field to include the directories: dist/, prompt/, and scripts/."

# Using heredoc to add 'files' key in package.json
# Using 'jq' to modify JSON in a more structured manner
tmp_file=$(mktemp)
jq '. + {"files": ["dist/", "prompt/", "scripts/"]}' < ./package.json > "$tmp_file" && mv "$tmp_file" ./package.json

echo "\033[32mDone: $goal\033[0m\n"