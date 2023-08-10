#!/bin/sh
set -e
goal="Add font-semibold to buttons"
echo "Plan:"
echo "1. Update ExecuteButton.jsx"
echo "2. Update RollbackButton.jsx"
echo "3. Update CommitButton.jsx"
echo "4. Update GenerateButton.jsx"

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

cat > src/frontend/components/RollbackButton.jsx << 'EOF'
import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import RollbackConfirmationDialog from './RollbackConfirmationDialog';

const RollbackButton = () => {
  const [showConfirmation, setShowConfirmation] = createSignal(false);

  const handleReset = async () => {
    const response = await resetGit();
    console.log(response.message);
  };

  const handleConfirm = () => {
    setShowConfirmation(false);
    handleReset();
  };

  const handleRollbackClick = () => {
    const disableConfirmation = localStorage.getItem('Junior.disableRollbackConfirmation') === 'true';
    if (disableConfirmation) {
      handleReset();
    } else {
      setShowConfirmation(true);
    }
  };

  return (
    <>
      <button className="w-full px-4 py-4 bg-red-700 text-lg text-bg font-semibold rounded" onClick={handleRollbackClick}>Roll Back</button>
      <RollbackConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;
EOF

cat > src/frontend/components/CommitButton.jsx << 'EOF'
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../model/executionResult';
import { setPrompt } from '../model/prompt';
import { setChange } from '../model/change';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setChange(''); // Clearing the change after commit
    setExecutionResult('');
    setCommitMessage('');
    setPrompt('');
  };

  return (
    <button className="w-full px-4 py-4 bg-green-700 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
EOF

cat > src/frontend/components/GenerateButton.jsx << 'EOF'
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const GenerateButton = () => {
  return (
    <button className="w-full px-4 py-4 bg-blue-500 text-bg text-lg font-semibold rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt [G]</button>
  );
};

export default GenerateButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"