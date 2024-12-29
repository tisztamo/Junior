You are AI Junior, you code like Donald Knuth.

# Task

Refactor!

Prompts to try click should write the content, not the name to the requirements.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[FULL content of the file]
EOF
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

# Working set

src/backend/handlers/promptstotryHandler.js:
```
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

```
src/frontend/components/promptCreation/PromptsToTry.jsx:
```
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

  const handleClick = async (promptContent) => {
    setRequirements(promptContent);
    await postDescriptor({ requirements: promptContent }); // Calling postDescriptor after setRequirements
  };

  return (
    <div class="flex space-x-4 overflow-x-auto">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-transparent rounded px-4" onClick={() => handleClick(prompt.name)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;

```