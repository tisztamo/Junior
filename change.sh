#!/bin/sh
set -e
goal="Move handleExecuteChange to service dir, update imports"
echo "Plan:"
echo "1. Move handleExecuteChange.js to src/frontend/service"
echo "2. Update relative paths in handleExecuteChange.js"
echo "3. Update import paths in ExecuteButton.jsx and keyBindings.js"

# Step 1: Move handleExecuteChange.js to src/frontend/service
mv src/frontend/model/handleExecuteChange.js src/frontend/service/handleExecuteChange.js

# Step 2: Update relative paths in handleExecuteChange.js
cat > src/frontend/service/handleExecuteChange.js << 'EOF'
import { executeChange } from './executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';
import { changeInput } from '../model/changeInput';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);
};

export default handleExecuteChange;
EOF

# Step 3: Update import paths in ExecuteButton.jsx and keyBindings.js

# ExecuteButton.jsx
cat > src/frontend/components/ExecuteButton.jsx << 'EOF'
import handleExecuteChange from '../service/handleExecuteChange';
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

# keyBindings.js
cat > src/frontend/config/keyBindings.js << 'EOF'
import handleExecuteChange from '../service/handleExecuteChange';
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const keyBindings = () => {
  return {
    'G': (e) => {
      handleGeneratePrompt();
    },
    'X': (e) => {
      handleExecuteChange();
    }
  };
};

export default keyBindings;
EOF

echo "\033[32mDone: $goal\033[0m\n"
