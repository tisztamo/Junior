#!/bin/sh
set -e
goal="Fix module import path in clearBranchesCommand.js"
echo "Plan:"
echo "1. Create a corrected version of clearBranchesCommand.js with the right path for clearBranches.js."
echo "2. Move the corrected file to replace the existing one."

cat > ./scripts/clearBranchesCommand.js << 'EOF'
import clearBranches from '../src/git/clearBranches.js';

clearBranches().catch(err => {
  console.error(`Failed to clear branches: ${err}`);
});
EOF

echo "\033[32mDone: $goal\033[0m\n"
