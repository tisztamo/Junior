import { writeFileSync } from 'fs';

export function createPromptYaml() {
  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: |
  1. Create the src/ dir
  2. Create src/main.js with a Hello World in Node.js
  3. Update package.json to enable running it
  4. Print instructions on how to run it`;

  writeFileSync('prompt.yaml', yamlContent);
}
