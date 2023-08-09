#!/bin/sh
set -e
goal="Rename deleteBranchesCommand to clearBranchesCommand"
echo "Plan:"
echo "1. Rename the file src/git/deleteBranchesCommand.js to src/git/clearBranchesCommand.js."
echo "2. Update the reference in package.json from src/deleteBranchesCommand.js to src/clearBranchesCommand.js to ensure coherence."
echo "3. Since there is no reference to the deleteBranchesCommand.js file in the codebase, renaming it will not affect other parts of the code."

# Rename deleteBranchesCommand.js to clearBranchesCommand.js
mv src/git/deleteBranchesCommand.js src/git/clearBranchesCommand.js

# Update the reference in package.json
jq '.scripts["delete-branches"] = "node ./scripts/clearBranchesCommand.js"' package.json > tmp.json && mv tmp.json package.json

echo "\033[32mDone: $goal\033[0m\n"
