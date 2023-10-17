#!/bin/sh
set -e
goal="Create npx command and enhance output options"
echo "Plan:"
echo "1. Update package.json to include the 'junior-news' bin command."
echo "2. Modify the readGitHistoryToMd.js script to accept the --output argument or JUNIOR_NEWS_OUTPUT environment variable for file output."
echo "3. Add a shebang to the readGitHistoryToMd.js script and make it executable."

# 1. Update package.json
jq '.bin["junior-news"] = "scripts/readGitHistoryToMd.js"' ./package.json > temp.json && mv temp.json ./package.json

# 2. Modify the readGitHistoryToMd.js script and 3. Add a shebang
cat > ./scripts/readGitHistoryToMd.js << 'EOF'
#!/usr/bin/env node
import fs from 'fs/promises';
import path from 'path';
import getGitHistory from '../src/git/getGitHistory.js';

function parseArgs() {
  const args = process.argv.slice(2);
  let outputArg;

  for (const arg of args) {
    if (arg.startsWith('--output=')) {
      outputArg = arg.split('=')[1];
      break;
    }
  }

  return {
    output: outputArg || process.env.JUNIOR_NEWS_OUTPUT || './tmp/new_commits.md'
  };
}

async function executeGitHistoryRead() {
  try {
    const { output } = parseArgs();
    const gitHistory = await getGitHistory();
    const dir = path.dirname(output);
    await fs.mkdir(dir, { recursive: true });
    await fs.writeFile(output, gitHistory);
  } catch (err) {
    console.error(err);
  }
}

executeGitHistoryRead();

EOF

# Making the script executable
chmod +x ./scripts/readGitHistoryToMd.js

echo "\033[32mDone: $goal\033[0m\n"