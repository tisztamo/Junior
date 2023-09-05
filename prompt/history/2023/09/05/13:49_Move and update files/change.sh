#!/bin/sh
set -e
goal="Move and update files"
echo "Plan:"
echo "1. Move generatePrompt.js to service directory"
echo "2. Update the imports in the moved generatePrompt.js"
echo "3. Update imports in handleGeneratePrompt.js"

# Step 1: Move generatePrompt.js to service directory
mv src/frontend/generatePrompt.js src/frontend/service/generatePrompt.js

# Step 2: Update the imports in the moved generatePrompt.js
cat > src/frontend/service/generatePrompt.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const generatePrompt = async (notes) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/generate`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes, systemPrompt: true })
  });

  const data = await response.json();

  if (response.status >= 400) {
    throw new Error(data.error);
  }

  return data;
};

export { generatePrompt };
EOF

# Step 3: Update imports in handleGeneratePrompt.js
cat > src/frontend/service/handleGeneratePrompt.js << 'EOF'
import { generatePrompt } from './generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';
import postDescriptor from './postDescriptor';
import { requirements } from '../model/requirements';

const handleGeneratePrompt = async () => {
  try {
    await postDescriptor({ requirements: requirements() });

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
  } catch (error) {
    alert(error.message);
  }
};

export default handleGeneratePrompt;
EOF

echo "\033[32mDone: $goal\033[0m\n"