import { writeFileSync } from 'fs';

export function createReadme() {
  const readmeContent = 'Project initialized with Junior';
  writeFileSync('README.md', readmeContent);
}
