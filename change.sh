#!/bin/sh
set -e
goal="Fix empty string update issue"
echo "Plan:"
echo "1. Modify updateDescriptorHandler.js to update fields even when they have empty strings."

cat > src/backend/handlers/updateDescriptorHandler.js << 'EOF'
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

const updateDescriptorHandler = async (req, res) => {
  const { requirements, attention } = req.body;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);

    if (requirements !== undefined) {
      document.requirements = requirements;
    }
    
    if (attention !== undefined) {
      document.attention = attention;
    }
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Descriptor updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

export default updateDescriptorHandler;
EOF

echo "\033[32mDone: $goal\033[0m\n"