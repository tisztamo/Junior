#!/bin/sh
set -e
goal="Enhance ExecuteButton component"
echo "Plan:"
echo "1. Modify the textarea to have a darker background than the button."
echo "2. Empty the textarea's content after execution."

# Step 1: Modify the textarea to have a darker background.
cat > src/frontend/components/ExecuteButton.jsx << 'EOF'
import { createEffect } from 'solid-js';
import handleExecuteChange from '../service/handleExecuteChange';
import { setChangeInput, changeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange();
    setChangeInput(''); // To clear the input after execution
  };

  // To clear the input content after execution
  createEffect(() => {
    if (changeInput()) {
      handleExecuteChange();
      setChangeInput('');
    }
  });

  return (
    <button className="w-full px-4 py-4 pb-3 bg-orange-300 text-lg text-bg font-semibold rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change [X]'
      ) : (
        <textarea
          rows="1"
          className="w-full px-2 py-2 bg-orange-500 text-lg text-bg font-semibold resize-none"  // Darker background than the button
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