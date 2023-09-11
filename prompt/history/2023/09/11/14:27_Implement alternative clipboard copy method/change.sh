#!/bin/sh
set -e
goal="Implement alternative clipboard copy method"
echo "Plan:"
echo "1. Create a new function to handle clipboard copying, using both the modern and alternative methods."
echo "2. Update handleGeneratePrompt.js to use the new clipboard copying function."

# Step 1: Create a new function to handle clipboard copying.
cat > ./src/frontend/service/copyToClipboard.js << 'EOF'
const copyToClipboard = async (text) => {
  if (navigator.clipboard && navigator.clipboard.writeText) {
    await navigator.clipboard.writeText(text);
    console.log('Prompt copied to clipboard!');
  } else {
    // Use the alternative method: Using a temporary textarea.
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    console.log('Prompt copied to clipboard using alternative method!');
  }
};

export default copyToClipboard;
EOF

# Step 2: Update handleGeneratePrompt.js to use the new clipboard copying function.
cat > ./src/frontend/service/handleGeneratePrompt.js << 'EOF'
import { generatePrompt } from './generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';
import postDescriptor from './postDescriptor';
import { requirements } from '../model/requirements';
import copyToClipboard from './copyToClipboard';

const handleGeneratePrompt = async () => {
  try {
    await postDescriptor({ requirements: requirements() });

    const response = await generatePrompt();

    await copyToClipboard(response.prompt);

    const htmlPrompt = marked(response.prompt);
    setPrompt(htmlPrompt);
  } catch (error) {
    alert(error.message);
  }
};

export default handleGeneratePrompt;
EOF

echo "\033[32mDone: $goal\033[0m\n"