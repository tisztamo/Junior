# Working set

src/init.js:
```
#!/usr/bin/env node
import { execSync } from 'child_process';
import { appendFileSync, writeFileSync, existsSync } from 'fs';
import { join } from 'path';

function juniorInit() {
  execSync('git init', { stdio: 'inherit' });
  
  const gitignorePath = join(process.cwd(), '.gitignore');
  const ignoreContent = ['prompt.yaml', 'prompt.md', 'change.sh'].join('\n');

  if (existsSync(gitignorePath)) {
    appendFileSync(gitignorePath, `\n${ignoreContent}`);
  } else {
    writeFileSync(gitignorePath, ignoreContent);
  }

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

Fix the following issue!

Factor out .gitignore creation to a new file in src/git/,Also gitignore node_modules/ if it is not already gitignored.

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

