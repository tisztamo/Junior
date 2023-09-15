#!/bin/sh
set -e
goal="Modify ignore list handling and file structure"
echo "Plan:"
echo "1. Modify the getIgnoreList.js to distinguish between './' prefixed ignores and regular ignores."
echo "2. Update readFileList.js to handle the new ignore list format and the root directory naming requirement."

cat > ./src/backend/fileutils/getIgnoreList.js << 'EOF'
function getIgnoreList() {
  const DEFAULT_IGNORE = ['.git', 'node_modules', './prompt'];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  const totalIgnore = [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];

  const nameIgnore = totalIgnore.filter(item => !item.startsWith('./'));
  const pathIgnore = totalIgnore.filter(item => item.startsWith('./')).map(item => item.slice(2));

  return { nameIgnore, pathIgnore };
}

export default getIgnoreList;

EOF

cat > ./src/backend/fileutils/readFileList.js << 'EOF'
import fs from 'fs';
import path from 'path';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const { nameIgnore, pathIgnore } = getIgnoreList();

  const itemDetails = await Promise.all(
    items.map(async item => {
      if (nameIgnore.includes(item)) return;
      const fullPath = path.join(dir, item);
      if (pathIgnore.includes(fullPath.replace(/^.\//, ''))) return;
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

  if (!relativePath) {
    return {
      type: "dir",
      name: ".",
      children: itemDetails.filter(Boolean)
    };
  } else {
    return itemDetails.filter(Boolean);
  }
}

export default readFileList;

EOF

echo "\033[32mDone: $goal\033[0m\n"