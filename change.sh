#!/bin/sh
set -e
goal="Bind X to handleExecuteChange, update label"
echo "Plan:"
echo "1. Update keyBindings.js to bind 'X' key to handleExecuteChange."
echo "2. Update ExecuteButton.jsx to add [X] to the button label with some space."

# Step 1: Update keyBindings.js to bind 'X' key to handleExecuteChange.
cat << 'EOF' > src/frontend/config/keyBindings.js
import handleExecuteChange from '../model/handleExecuteChange';
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const keyBindings = () => {
  return {
    'G': (e) => {
      handleGeneratePrompt();
      console.log('G key pressed'); // Temporary log
    },
    'X': (e) => {
      handleExecuteChange();
      console.log('X key pressed'); // Temporary log
    }
  };
};

export default keyBindings;
EOF

# Step 2: Update ExecuteButton.jsx to add [X] to the button label with some space.
cat << 'EOF' > src/frontend/components/ExecuteButton.jsx
import handleExecuteChange from '../model/handleExecuteChange';
import { setChangeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange();
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change [X]'
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
