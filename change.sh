#!/bin/sh
set -e
goal="Add [G] to button label, remove console.logs"
echo "Plan:"
echo "1. Modify GenerateButton.jsx to include [G] in the button label"
echo "2. Remove unnecessary console.log statements from keyBindings.js"

# Step 1: Modify GenerateButton.jsx
cat << 'EOF' > src/frontend/components/GenerateButton.jsx
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const GenerateButton = () => {
  return (
    <button className="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt [G]</button>
  );
};

export default GenerateButton;
EOF

# Step 2: Remove unnecessary console.log statements
cat << 'EOF' > src/frontend/config/keyBindings.js
import handleExecuteChange from '../model/handleExecuteChange';
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const keyBindings = () => {
  return {
    'G': (e) => {
      handleGeneratePrompt();
    },
    'X': (e) => {
      handleExecuteChange();
    }
  };
};

export default keyBindings;
EOF

echo "\033[32mDone: $goal\033[0m\n"
