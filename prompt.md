# Working set

src/prompt/promptDescriptorDefaults.js:
```
import { loadPromptFile } from './loadPromptFile.js';
import { getPromptDirectories } from './getPromptDirectories.js';
import fs from 'fs';
import path from 'path';

const promptDescriptorDefaults = async () => {
  let promptDescriptorDefaults = {};
  
  const promptDirs = getPromptDirectories();
  let uniqueFiles = new Set();

  // Store all unique file names
  for(let dir of promptDirs) {
    const files = fs.readdirSync(dir).filter(file => file.endsWith('.md'));
    files.forEach(file => uniqueFiles.add(file));
  }

  // Load only unique files
  for (let file of uniqueFiles) {
    const fileNameWithoutExtension = path.basename(file, '.md');
    promptDescriptorDefaults[fileNameWithoutExtension] = await loadPromptFile(`prompt/${file}`);
  }
  
  return promptDescriptorDefaults;
}

export default promptDescriptorDefaults;

```


# Task

Fix the following issue!

Handle the case silently when a prompt folder does not exests.

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

