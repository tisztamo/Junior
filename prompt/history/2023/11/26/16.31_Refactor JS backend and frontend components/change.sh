#!/bin/sh
set -e
goal="Refactor JS backend and frontend components"
echo "Plan:"
echo "1. Refactor promptstotryHandler.js"
echo "2. Refactor PromptsToTry.jsx"

# Refactoring promptstotryHandler.js
cat > src/backend/handlers/promptstotryHandler.js << 'EOF'
import readFileList from '../fileutils/readFileList.js';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';

async function readFiles(dirPath) {
  const files = await readFileList(dirPath);
  return Promise.all(files.children.map(async file => {
    const content = await fs.promises.readFile(path.join(dirPath, file.name), 'utf8');
    return { name: file.name, content };
  }));
}

export async function promptstotryHandler(req, res) {
    const PROMPTS_DIR = 'prompt/totry';
    let dirPath = path.join(process.cwd(), PROMPTS_DIR);
    let fileContents = await readFiles(dirPath);
    
    if (!fileContents.length) {
      const projectRoot = getProjectRoot();
      dirPath = path.join(projectRoot, PROMPTS_DIR);
      fileContents = await readFiles(dirPath);
    }

    res.json(fileContents);
}
EOF
echo "\033[32mDone: Refactor promptstotryHandler.js\033[0m\n"

# Refactoring PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << 'EOF'
import { For, onMount } from 'solid-js';
import { promptsToTry, setPromptsToTry } from '../../model/promptsToTryModel';
import { fetchPromptsToTry } from '../../service/fetchPromptsToTry';
import { setRequirements } from '../../model/requirements';
import postDescriptor from '../../service/postDescriptor'; // Importing postDescriptor

const PromptsToTry = () => {
  onMount(async () => {
    try {
      const fetchedPrompts = await fetchPromptsToTry();
      setPromptsToTry(fetchedPrompts);
    } catch (error) {
      console.error('Error fetching prompts to try:', error);
    }
  });

  const handleClick = async (prompt) => {
    setRequirements(prompt.content);
    await postDescriptor({ requirements: prompt.content });
  };

  return (
    <div class="flex space-x-4 overflow-x-auto">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-transparent rounded px-4" onClick={() => handleClick(prompt)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;
EOF
echo "\033[32mDone: Refactor PromptsToTry.jsx\033[0m\n"

echo "\033[32mDone: $goal\033[0m\n"