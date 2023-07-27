import { appendFileSync, writeFileSync, existsSync, readFileSync } from 'fs';
import { join } from 'path';

function createGitignore() {
  const gitignorePath = join(process.cwd(), '.gitignore');
  const ignoreContent = ['prompt.yaml', 'prompt.md', 'change.sh', 'node_modules'];

  let existingIgnores = [];

  if (existsSync(gitignorePath)) {
    const gitignoreFileContent = readFileSync(gitignorePath, 'utf-8');
    existingIgnores = gitignoreFileContent.split('\n');
  }

  ignoreContent.forEach((item) => {
    if (!existingIgnores.includes(item)) {
      appendFileSync(gitignorePath, `\n${item}`);
    }
  });
}

export { createGitignore };
