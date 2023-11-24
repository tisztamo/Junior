#!/bin/sh
set -e
goal="Implement Line Ending Conversion and Reorganize Code"
echo "Plan:"
echo "1. Create new directory."
echo "2. Move handleExecuteChange.js to new directory."
echo "3. Create convertLineEndings.js."
echo "4. Update ExecuteButton.jsx."

# Create new directory
mkdir -p src/frontend/service/execute

# Move handleExecuteChange.js to new directory and modify
cat > src/frontend/service/execute/handleExecuteChange.js << 'EOF'
import { convertLineEndings } from './convertLineEndings';
import executeChange from '../executeChange';
import { setExecutionResult } from '../../model/executionResult';
import { setChange } from '../../model/change';
import { changeInput } from '../../model/changeInput';
import { fetchGitStatus } from '../fetchGitStatus';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  let change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  change = convertLineEndings(change);
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);
  fetchGitStatus();
};

export default handleExecuteChange;
EOF

# Create convertLineEndings.js
cat > src/frontend/service/execute/convertLineEndings.js << 'EOF'
export const convertLineEndings = (text) => {
  return text.replace(/\r\n/g, '\n');
};
EOF

# Update ExecuteButton.jsx
sed -i '' 's|../service/handleExecuteChange|../service/execute/handleExecuteChange|' src/frontend/components/ExecuteButton.jsx

echo "\033[32mDone: $goal\033[0m\n"