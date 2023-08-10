#!/bin/sh
set -e
goal="Refactor ExecuteButton by factoring changeInput"
echo "Plan:"
echo "1. Create a new file in model directory to handle changeInput"
echo "2. Update ExecuteButton.jsx to import changeInput from the new file"

# Step 1: Create a new file in model directory to handle changeInput
cat > src/frontend/model/changeInput.js << 'EOF'
import { createSignal } from 'solid-js';

const [changeInput, setChangeInput] = createSignal('');

export { changeInput, setChangeInput };
EOF

# Step 2: Update ExecuteButton.jsx to import changeInput from the new file
cat > src/frontend/components/ExecuteButton.jsx << 'EOF'
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';
import { changeInput, setChangeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handleExecuteChange = async () => {
    const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
    const response = await executeChange(change);
    setChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange();
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change'
      ) : (
        <textarea
          rows="1"
          class="w-full px-2 py-2 bg-white text-black resize-none"
          placeholder="Paste here to execute"
          value={changeInput()}
          onPaste={handlePaste}
        />
      )}
    </button>
  );
};

export default ExecuteButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
