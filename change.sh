#!/bin/sh
# Goal: Fix issues in index.html and adjust button styles
# Plan:
# 1. Remove 'xxx' from index.html.
# 2. Update button styles in the corresponding component files to ensure uniform width and vivid color for the reset button.

# Step 1: Remove 'xxx' from index.html
cat > src/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/frontend/index.jsx"></script>
</body>
</html>
EOF

# Step 2: Update button styles to ensure a uniform width and a vivid color for the reset button.
# I'll increase the button width to 'w-64' (16rem), which should be sufficient for the longest label.
# The reset button color will be changed to 'bg-red-700' for a more vivid appearance.

cat > src/frontend/components/ResetButton.jsx << 'EOF'
import { resetGit } from '../service/resetGit';

const ResetButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Reset Git</button>
  );
};

export default ResetButton;
EOF

cat > src/frontend/components/ExecuteButton.jsx << 'EOF'
import { executeChange } from '../service/executeChange';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
EOF

cat > src/frontend/components/StartButton.jsx << 'EOF'
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';

const StartButton = ({notes, setPrompt}) => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt(notes());

    copy(response.prompt)
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
    <button class="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default StartButton;
EOF
