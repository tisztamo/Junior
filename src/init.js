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
