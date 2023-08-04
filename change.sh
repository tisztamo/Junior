#!/bin/sh
set -e
goal="Implement clipboard reading fallback with input box"
echo "Plan:"
echo "1. Modify ExecuteButton.jsx to include a check for navigator.clipboard.readText availability."
echo "2. If unavailable, render an input box inside the button with placeholder."
echo "3. Execute the change when text is pasted into the input box."

cat > src/frontend/components/ExecuteButton.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { executeChange } from '../service/executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';

const ExecuteButton = () => {
  const [inputAvailable, setInputAvailable] = createSignal(true);
  const [changeInput, setChangeInput] = createSignal('');

  const handleExecuteChange = async () => {
    let change = changeInput();
    if (inputAvailable() && navigator.clipboard) {
      change = await navigator.clipboard.readText();
    }
    const response = await executeChange(change);
    setChange(change);
    setExecutionResult(response.output);
    console.log(response.output);
  };

  // Check if clipboard reading is available
  createEffect(() => {
    if (!navigator.clipboard || !navigator.clipboard.readText) {
      setInputAvailable(false);
    }
  });

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>
      {inputAvailable() ? (
        'Paste & Execute Change'
      ) : (
        <input
          type="text"
          class="w-full px-2 py-2 bg-white text-black"
          placeholder="Paste the change here to execute"
          value={changeInput()}
          onInput={(e) => setChangeInput(e.currentTarget.value)}
        />
      )}
    </button>
  );
};

export default ExecuteButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
