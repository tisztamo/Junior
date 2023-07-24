#!/bin/sh
set -e
goal="Update 'message' field to 'output'"
echo "Plan:"
echo "1. Replace 'message' with 'output' in ExecuteButton.jsx"

cat > src/frontend/components/ExecuteButton.jsx << 'EOF'
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../stores/executionResult';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
