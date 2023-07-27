import { writeFileSync } from 'fs';

export function createPromptYaml() {
  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: Create a Hello World in Node.js`;

  writeFileSync('prompt.yaml', yamlContent);
}
