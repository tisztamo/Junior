import { writeFileSync } from 'fs';

export function createProjectSpecifics() {
  const markdownContent = `## Project Specifics\n`;

  writeFileSync('./prompt/projectSpecifics.md', markdownContent);
}
