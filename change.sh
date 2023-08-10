#!/bin/sh
set -e
goal="Move fetchGitStatus call to the handler"
echo "Plan:"
echo "1. Move the fetchGitStatus call from executeChange.js to handleExecuteChange.js"
echo "2. Update exports to ensure each file exports a single function"

# Step 1: Modify executeChange.js, removing the fetchGitStatus call
cat > src/frontend/service/executeChange.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const executeChange = async (change) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/execute`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ change })
  });

  const data = await response.json();

  return data;
};

export default executeChange;
EOF

# Step 2: Modify handleExecuteChange.js, adding the fetchGitStatus call
cat > src/frontend/service/handleExecuteChange.js << 'EOF'
import executeChange from './executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';
import { changeInput } from '../model/changeInput';
import { fetchGitStatus } from './fetchGitStatus';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);

  // Fetch git status after code execution
  fetchGitStatus();
};

export default handleExecuteChange;
EOF

echo "\033[32mDone: $goal\033[0m\n"
