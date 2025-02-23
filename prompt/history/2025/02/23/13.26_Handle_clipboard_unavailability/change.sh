#!/bin/sh
set -e

goal="Handle clipboard unavailability"

echo "Plan:"
echo "1. Modify ExecuteButton.jsx to use input event when clipboard is unavailable."
echo "2. Ensure text execution happens when input length exceeds 50 characters."

echo "Updating ExecuteButton.jsx..."

cat > src/frontend/components/ExecuteButton.jsx << EOF
import { createEffect } from 'solid-js';
import handleExecuteChange from '../service/execute/handleExecuteChange';
import { setChangeInput, changeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handleInput = async (e) => {
    setChangeInput(e.target.value);
    if (e.target.value.length > 50) {
      await handleExecuteChange();
      setChangeInput(''); // Clear input after execution
    }
  };

  return (
    <button className="w-full px-4 py-4 pb-3 bg-orange-300 text-lg text-bg font-semibold rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change [X]'
      ) : (
        <textarea
          rows="1"
          className="w-full px-2 py-2 bg-orange-200 text-lg text-bg font-semibold resize-none"
          placeholder="Paste here to execute"
          value={changeInput()}
          onInput={handleInput}
        />
      )}
    </button>
  );
};

export default ExecuteButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
