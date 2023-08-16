#!/bin/sh
set -e
goal="Fix changeInput reference error"
echo "Plan:"
echo "1. Import 'changeInput' function from its respective file/module since it's not defined in ExecuteButton.jsx"
echo "2. Modify ExecuteButton.jsx to use imported 'changeInput'"

# Assuming changeInput is exported from '../model/changeInput'
# Create/Edit the ExecuteButton.jsx
cat <<EOF >src/frontend/components/ExecuteButton.jsx
import handleExecuteChange from '../service/handleExecuteChange';
import { setChangeInput, changeInput } from '../model/changeInput';

const ExecuteButton = () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);

  const handlePaste = async (e) => {
    const paste = (e.clipboardData || window.clipboardData).getData('text');
    setChangeInput(paste);
    handleExecuteChange();
  };

  return (
    <button className="w-full px-4 py-4 bg-orange-300 text-lg text-bg font-semibold rounded" onClick={handleExecuteChange}>
      {clipboardAvailable ? (
        'Paste & Execute Change [X]'
      ) : (
        <textarea
          rows="1"
          className="w-full px-2 py-2 bg-white text-lg text-bg font-semibold resize-none"
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
