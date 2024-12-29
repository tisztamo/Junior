#!/bin/sh
set -e
goal="Move bin commands from scripts to bin directory"
echo "Plan:"
echo "1. Create bin directory."
echo "2. Move relevant command files from scripts to bin."
echo "3. Copy files also used in the 'scripts' section to the scripts directory."
echo "4. Update package.json to point to the new location."

# Step 1: Create bin directory.
mkdir -p bin

# Step 2: Move relevant command files from scripts to bin.
mv scripts/web.js bin/web.js
mv scripts/cli.js bin/cli.js
mv scripts/init.js bin/init.js
mv scripts/junior-rollback.js bin/junior-rollback.js
mv scripts/readGitHistoryToMd.js bin/readGitHistoryToMd.js

# Step 3: Copy files also used in the 'scripts' section to the scripts directory.
cp bin/cli.js scripts/cli.js
cp bin/junior-rollback.js scripts/junior-rollback.js

# Step 4: Update package.json using jq tool to handle keys with hyphens.
jq '.bin |= {"junior": "bin/web.js", "junior-web": "bin/web.js", "junior-cli": "bin/cli.js", "junior-init": "bin/init.js", "junior-rollback": "bin/junior-rollback.js", "junior-news": "bin/readGitHistoryToMd.js"}' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "\033[32mDone: $goal\033[0m\n"