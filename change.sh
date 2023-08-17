#!/bin/sh
set -e
goal="Fix import/export issue"
echo "Plan:"
echo "1. Change the export in 'updateRequirementsHandler.js' to a default export."
echo "2. Verify the import in 'setupPromptRoutes.js' uses the default import syntax."

# Step 1: Change the export in 'updateRequirementsHandler.js' to a default export.
cat > src/backend/handlers/updateRequirementsHandler.js << 'EOF'
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

const updateRequirementsHandler = async (req, res) => {
  const requirements = req.body.requirements;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);
    document.requirements = requirements;
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Requirements updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

export default updateRequirementsHandler;
EOF

# Step 2: Verify the import in 'setupPromptRoutes.js' is correct.
# It already uses the correct syntax. No changes required.

echo "\033[32mDone: $goal\033[0m\n"
