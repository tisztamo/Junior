import { join } from 'path';
import { promises as fs } from 'fs';
import { searchFiles } from '../src/command/updateConfigList/searchFiles.js';

const BASE_DIR = '.';
const SRC_DIR = join(BASE_DIR, 'src');
const OUTPUT_FILE = join(BASE_DIR, 'docs/design/config-file-list.yaml');

async function findConfigAccessFiles() {
  const files = await searchFiles(SRC_DIR);

  const accessedFiles = files.filter(file => 
    file.content.includes('process.env') || file.content.includes('process.argv')
  );

  return accessedFiles.map(file => file.path);
}

async function main() {
  const fileList = await findConfigAccessFiles();
  
  const yamlContent = `envAndCli:\n${fileList.map(file => `  - ${file}`).join('\n')}`;
  await fs.writeFile(OUTPUT_FILE, yamlContent, 'utf8');
}

main();
