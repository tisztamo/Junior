#!/bin/sh
set -e
goal="Factor handleGeneratePrompt, bind G key to call it"
echo "Plan:"
echo "1. Move the handleGeneratePrompt function to a new file src/frontend/service/handleGeneratePrompt.js"
echo "2. Import and utilize handleGeneratePrompt in src/frontend/components/GenerateButton.jsx"
echo "3. Modify src/frontend/config/keyBindings.js to call handleGeneratePrompt when the G key is pressed"

# Step 1: Create handleGeneratePrompt.js in the service directory with the handleGeneratePrompt function
echo "src/frontend/service/handleGeneratePrompt.js" > src/frontend/service/handleGeneratePrompt.js
cat <<EOF > src/frontend/service/handleGeneratePrompt.js
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';

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

export default handleGeneratePrompt;
EOF

# Step 2: Modify GenerateButton.jsx to import handleGeneratePrompt from the new file
cat <<EOF > src/frontend/components/GenerateButton.jsx
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const GenerateButton = () => {
  return (
    <button className="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default GenerateButton;
EOF

# Step 3: Modify keyBindings.js to call handleGeneratePrompt when G key is pressed
cat <<EOF > src/frontend/config/keyBindings.js
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const keyBindings = () => {
  return {
    'G': (e) => {
      handleGeneratePrompt();
      console.log('G key pressed'); // Temporary log
    }
  };
};

export default keyBindings;
EOF

echo "\033[32mDone: $goal\033[0m\n"
