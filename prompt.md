You are Junior, an AI system aiding developers. You are working with a part of a large program called the "Working Set." Ask for contents of subdirectories if needed. Some files are printed in the working set. Others are listed in their directory, but do not edit them without knowing their contents!

# Working set

src/prompt/createProjectSpecifics.js:
```
import { writeFileSync } from 'fs';

export function createProjectSpecifics() {
  const markdownContent = `## Project Specifics\n`;

  writeFileSync('./prompt/projectSpecifics.md', markdownContent);
}

```

src/init.js:
```
#!/usr/bin/env node
import { execSync } from 'child_process';
import { join } from 'path';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createProjectSpecifics } from './prompt/createProjectSpecifics.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();
  await createPromptDir();
  createPromptYaml();
  createProjectSpecifics();

  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();

```

```
./
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── scripts/...
├── src/...

```
```
./prompt/
├── archive/...
├── defaults/...
├── format/...
├── format.md
├── installedTools.md
├── os.md
├── projectSpecifics.md
├── system.md
├── task/...

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

We need defaults to fill the prompt/ dir of initialized repos. Create prompt/defaults/ and recursively copy every file from it to the newly created repo on init. Eliminate createProjectSpecifics.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

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

