# Working set

src/init.js:
```
#!/usr/bin/env node
import { execSync } from 'child_process';
import { writeFileSync } from 'fs';
import { join } from 'path';
import { createGitignore } from './git/createGitignore.js';

function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();

  execSync('git add .gitignore', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: Create a Hello World in Node.js`;

  writeFileSync('prompt.yaml', yamlContent);

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Factor out prompt.yaml creation to src/prompt/createPromptYaml.js! - Also create and call src/prompt/createProjectSpecifics.js which creates ./prompt/projectSpecifics.md with the content &#34;## Project Specifics\n&#34;!


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

