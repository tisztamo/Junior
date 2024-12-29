#!/bin/sh
set -e
goal="Implement specified feature"
echo "Plan:"
echo "1. Delete prompt/defaults/prompt.yaml."
echo "2. Update createPromptYaml function in src/prompt/createPromptYaml.js."
echo "3. Create new instructions."

# Step 1: Delete prompt/defaults/prompt.yaml
rm prompt/defaults/prompt.yaml

# Step 2: Update createPromptYaml function
cat > src/prompt/createPromptYaml.js << 'EOF'
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
EOF

echo "\033[32mDone: $goal\033[0m\n"