#!/bin/sh
set -e
goal="Fix getPromptDirectories function"
echo "Plan:"
echo "1. Edit src/prompt/getPromptDirectories.js to use import.meta to get the directory of the source file"
echo "2. Adjust the function to generate directories relative to the project root and the working directory"

cat << 'EOF' > src/prompt/getPromptDirectories.js
import path from 'path';
import url from 'url';

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const getPromptDirectories = () => {
  const rootDir = path.resolve();
  const workingDir = process.cwd();
  
  return [
    path.join(path.resolve(__dirname, '../../'), 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };
EOF

echo "\033[32mDone: $goal\033[0m\n"
