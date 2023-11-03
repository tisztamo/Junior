#!/bin/sh
set -e
goal="Refactor promptDir checks using config"
echo "Plan:"
echo "1. Import descriptor file name from the config in prepareDirForJunior.js."
echo "2. Use the config variable for the 'prompt.yaml' check, ensuring it's relative to the current directory."

# Step 1: Import descriptor file name from the config in prepareDirForJunior.js
# Step 2: Use the config variable for the 'prompt.yaml' check
cat > ./src/prompt/prepareDirForJunior.js << 'EOF'
import fs from 'fs';
import path from 'path';
import { createPromptYaml } from './createPromptYaml.js';
import { juniorInit } from '../git/juniorInit.js';
import { descriptorFileName } from './promptDescriptorConfig.js'; // Import the descriptor file name

export async function prepareDirForJunior() {
  const promptDir = path.join(process.cwd(), 'prompt');

  if (!fs.existsSync(promptDir)) {
    console.warn('\x1b[33mWarning: Initializing Junior...\x1b[0m');
    await juniorInit();
  } else {
    const promptYaml = path.join(process.cwd(), descriptorFileName); // Use the descriptor file name from the config, relative to the current directory
    if (!fs.existsSync(promptYaml)) {
      createPromptYaml();
    }
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"