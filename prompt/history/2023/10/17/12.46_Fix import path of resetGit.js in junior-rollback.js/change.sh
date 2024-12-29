#!/bin/sh
set -e

goal="Fix import path of resetGit.js in junior-rollback.js"
echo "Plan:"
echo "1. Fix the import path in junior-rollback.js"

cat > ./scripts/junior-rollback.js << 'EOF'
#!/usr/bin/env node
import resetGit from '../src/git/resetGit.js';

async function executeRollback() {
  try {
    await resetGit();
  } catch (err) {
    console.error();
  }
}

executeRollback();
EOF

echo "\033[32mDone: $goal\033[0m\n"