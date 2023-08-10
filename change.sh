#!/bin/sh
set -e
goal="Fix error handling in generateHandler and frontend"
echo "Plan:"
echo "1. Modify generateHandler.js to handle ENOENT with a 404 status code and other errors with a 500 status code."
echo "2. Modify generatePrompt.js to throw an error if the response code shows any error."
echo "3. Modify handleGeneratePrompt.js to catch errors from generatePrompt and alert the error message."

# Step 1: Modify generateHandler.js
cat > src/backend/handlers/generateHandler.js << 'EOF'
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  try {
    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    if (error.message.startsWith("ENOENT")) {
      res.status(404).json({ error: error.message });
    } else {
      res.status(500).json({ error: error.message });
    }
  }
};
EOF

# Step 2: Modify generatePrompt.js
cat > src/frontend/generatePrompt.js << 'EOF'
import { getBaseUrl } from './getBaseUrl';

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

# Step 3: Modify handleGeneratePrompt.js
cat > src/frontend/service/handleGeneratePrompt.js << 'EOF'
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';

const handleGeneratePrompt = async () => {
  try {
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
