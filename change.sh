#!/bin/sh
set -e
goal="Revert src/frontend/ to original state"
echo "Plan:"
echo "1. Identify the common ancestor commit with the main branch (or another specific branch)"
echo "2. Checkout the src/frontend/ directory at that commit"
echo "3. Commit the changes to revert the src/frontend/ directory to its original state"

# Step 1: Identify the common ancestor commit with the main branch (replace 'main' with the specific branch if needed)
branch_creation_commit=$(git merge-base HEAD main)

echo "Branch creation commit: $branch_creation_commit"

# Step 2: Checkout the src/frontend/ directory at that commit
git checkout $branch_creation_commit -- src/frontend/

# Step 3: Commit the changes
git add src/frontend/
git commit -m "Revert src/frontend/ to its state at branch creation"

echo "\033[32mDone: $goal\033[0m\n"
