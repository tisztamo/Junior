#!/bin/sh
set -e
goal="Set JuniorOpenSourceProject as the publisher"
echo "Plan:"
echo "1. Update package.json to include the 'publisher' field with value 'JuniorOpenSourceProject'"
echo "2. Save changes to the package.json"

# Change to the appropriate directory
cd integrations/vscode

# Update package.json using the 'jq' command-line JSON processor
jq '.publisher="JuniorOpenSourceProject"' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "\033[32mDone: $goal\033[0m\n"
