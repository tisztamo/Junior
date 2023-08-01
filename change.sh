#!/bin/sh
set -e
goal="Refactor GenerateButton to use html5 clipboard API"
echo "Plan:"
echo "1. Uninstall clipboard-copy using npm"
echo "2. Modify GenerateButton.jsx to use the html5 clipboard API instead of clipboard-copy"
echo "3. Replacing the entire file with the updated content"

# Step 1: Uninstall clipboard-copy using npm
npm uninstall clipboard-copy

# Step 2: Modify GenerateButton.jsx to use the html5 clipboard API instead of clipboard-copy
cat > ./src/frontend/components/GenerateButton.jsx << 'EOF'
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../stores/prompt';

const GenerateButton = () => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt();

    navigator.clipboard.writeText(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <button className="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default GenerateButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
