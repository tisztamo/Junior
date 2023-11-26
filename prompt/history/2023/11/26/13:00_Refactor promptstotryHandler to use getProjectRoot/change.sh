#!/bin/sh
set -e
goal="Refactor promptstotryHandler to use getProjectRoot"
echo "Plan:"
echo "1. Modify promptstotryHandler.js to use getProjectRoot function."
echo "2. Define a constant for the directory path."

cat > src/backend/handlers/promptstotryHandler.js << 'EOF'
import readFileList from '../fileutils/readFileList.js';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';

export async function promptstotryHandler(req, res) {
    const PROMPTS_DIR = 'prompt/totry';
    let dirPath = path.join(process.cwd(), PROMPTS_DIR);
    let files = await readFileList(dirPath);
    
    if (!files.children.length) {
      const projectRoot = getProjectRoot();
      dirPath = path.join(projectRoot, PROMPTS_DIR);
      files = await readFileList(dirPath);
    }

    const fileContents = await Promise.all(files.children.map(async file => {
      const content = await fs.promises.readFile(path.join(dirPath, file.name), 'utf8');
      return { name: file.name, content };
    }));
    res.json(fileContents);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"