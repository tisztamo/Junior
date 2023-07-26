#!/bin/sh
set -e
goal="Add porcelain=v1 to git status command"
echo "Plan:"
echo "1. Add --porcelain=v1 option to git status command in gitStatus.js"

/bin/cat <<EOF >src/git/gitStatus.js
import { promisify } from 'util';
import { exec } from 'child_process';

const execAsync = promisify(exec);

export default async function gitStatus() {
  try {
    const { stdout, stderr } = await execAsync('git status --porcelain=v1');
    return stdout;
  } catch (error) {
    console.error(`exec error: ${error}`);
    throw error;
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
