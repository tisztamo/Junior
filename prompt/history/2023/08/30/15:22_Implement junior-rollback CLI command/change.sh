#!/bin/sh
set -e
goal="Implement junior-rollback CLI command"
echo "Plan:"
echo "1. Create a new executable file called junior-rollback.js with a shebang to execute resetGit."
echo "2. Modify the bin field in package.json to add the command 'junior-rollback' and link to the new executable file."

# 1. Create a new executable file called junior-rollback.js with a shebang to execute resetGit.
cat > src/junior-rollback.js <<EOF
#!/usr/bin/env node
import resetGit from './git/resetGit.js';

async function executeRollback() {
  try {
    await resetGit();
  } catch (err) {
    console.error();
  }
}

executeRollback();
EOF

chmod +x src/junior-rollback.js

# 2. Modify the bin field in package.json to add the command 'junior-rollback' and link to the new executable file.
tmpfile=$(mktemp)
jq '.bin["junior-rollback"] = "src/junior-rollback.js"' package.json > "$tmpfile"
mv "$tmpfile" package.json

echo "\033[32mDone: $goal\033[0m\n"