#!/bin/sh
set -e
goal="Rename stores to model, maintaining coherence"
echo "Plan:"
echo "1. Rename src/frontend/stores to src/frontend/model"
echo "2. Update any references to the old path in code to prevent breakage"

# Rename src/frontend/stores to src/frontend/model
mv src/frontend/stores src/frontend/model

# Find and replace all occurrences of "stores" with "model" in the src/frontend directory
# The command now searches all text files, not just .js and .jsx
find src/frontend -type f -exec grep -Iq . {} \; -exec sed -i '' 's/stores/model/g' {} +

echo "\033[32mDone: $goal\033[0m\n"
