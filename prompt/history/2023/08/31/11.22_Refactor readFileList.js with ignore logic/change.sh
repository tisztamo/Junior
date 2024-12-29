#!/bin/sh
set -e
goal="Refactor readFileList.js with ignore logic"
echo "Plan:"
echo "1. Add a function to get ignore list from constants, cli args and env vars."
echo "2. Refactor the main function to use the ignore list for filtering."
echo "3. Update the exports and imports as per the project specifics."

# 1. Add a function to get ignore list
cat > src/backend/fileutils/getIgnoreList.js <<EOF
function getIgnoreList() {
  const DEFAULT_IGNORE = ['.git', 'node_modules', 'prompt'];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  return [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];
}

export default getIgnoreList;
EOF

# 2. Refactor the main function
cat > src/backend/fileutils/readFileList.js <<EOF
import fs from 'fs';
import path from 'path';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const ignoreList = getIgnoreList();

  const itemDetails = await Promise.all(
    items.map(async item => {
      if (ignoreList.includes(item)) return;
      const fullPath = path.join(dir, item);
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        return {
          type: "dir",
          name: item,
          children: await readFileList(fullPath, path.join(relativePath, item))
        };
      } else {
        return {
          type: "file",
          name: item,
          path: path.join(relativePath, item)
        };
      }
    })
  );

  return itemDetails.filter(Boolean);
}

export default readFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"