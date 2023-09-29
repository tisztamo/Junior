#!/bin/sh
set -e
goal="Generate config file list for environment & argv access"
echo "Plan:"
echo "1. Set up the directory structure."
echo "2. Create the main script (updateConfigList.js)."
echo "3. Implement helper functions in the new directory."
echo "4. Output to the specified yaml file."
echo "5. Run the generated Node.js script."

# Setting up the directory structure
mkdir -p src/command/updateConfigList
touch ./scripts/updateConfigList.js

# Creating main script
cat > ./scripts/updateConfigList.js << 'EOF'
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
EOF

# Implementing helper function
cat > src/command/updateConfigList/searchFiles.js << 'EOF'
import { promises as fs } from 'fs';
import { join } from 'path';

async function searchFiles(dir) {
  const dirents = await fs.readdir(dir, { withFileTypes: true });
  const files = await Promise.all(dirents.map(async (dirent) => {
    const res = join(dir, dirent.name);
    if (dirent.isDirectory()) {
      return searchFiles(res);
    } else if (dirent.isFile() && res.endsWith('.js')) {
      const content = await fs.readFile(res, 'utf8');
      return { path: res, content };
    }
    return null;
  }));

  return files.flat().filter(Boolean);
}

export { searchFiles };
EOF

# Run the Node.js script
node ./scripts/updateConfigList.js

echo "\033[32mDone: $goal\033[0m\n"