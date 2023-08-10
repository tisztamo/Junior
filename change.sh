#!/bin/sh
set -e
goal="Remove try-catch, allow errors out in processFile"
echo "Plan:"
echo "1. Remove the try-catch block from src/attention/processFile.js"
echo "2. Simplify the function accordingly"

cat << 'EOF' > src/attention/processFile.js
import fs from 'fs'
import path from 'path'
import util from 'util'

const readFile = util.promisify(fs.readFile)

export const processFile = async (root, p) => {
  const fullPath = path.join(root, p)
  const content = await readFile(fullPath, "utf8")
  return `${p}:\n\`\`\`\n${content}\n\`\`\`\n`
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
