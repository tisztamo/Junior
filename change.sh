#!/bin/sh
set -e
goal="Fix task update issue with new save/load prompt descriptors"
echo "Plan:"
echo "1. Create savePromptDescriptor.js"
echo "2. Update updateTaskHandler.js to use savePromptDescriptor and loadPromptDescriptor"
echo "3. Confirm changes."

cat > src/prompt/savePromptDescriptor.js << 'EOF'
import fs from 'fs';
import util from 'util';

const writeFile = util.promisify(fs.writeFile);
import { descriptorFileName } from "./promptDescriptorConfig.js";

const savePromptDescriptor = async (data) => {
  await writeFile(descriptorFileName, data, 'utf8');
};

export { savePromptDescriptor };
EOF

cat > src/backend/handlers/updateTaskHandler.js << 'EOF'
import path from 'path';
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

export const updateTaskHandler = async (req, res) => {
  const task = req.body.task;
  
  try {
    const fileContent = await loadPromptDescriptor();

    const document = yaml.load(fileContent);
    document.task = path.join("prompt", "task", task);
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
