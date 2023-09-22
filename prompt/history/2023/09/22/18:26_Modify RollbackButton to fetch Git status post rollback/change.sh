#!/bin/sh
set -e
goal="Modify RollbackButton to fetch Git status post rollback"
echo "Plan:"
echo "1. Modify RollbackButton.jsx to call fetchGitStatus after rollback"

# Here we are using a heredoc to modify the RollbackButton.jsx file
cat > ./src/frontend/components/RollbackButton.jsx << 'EOF'
import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import { fetchGitStatus } from '../service/fetchGitStatus';
import RollbackConfirmationDialog from './RollbackConfirmationDialog';
import clearState from '../service/clearState';

const RollbackButton = () => {
  const [showConfirmation, setShowConfirmation] = createSignal(false);

  const handleReset = async () => {
    const response = await resetGit();
    console.log(response.message);
    clearState();
    await fetchGitStatus(); // Fetch Git status after rollback
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
      <button className="w-full px-4 py-4 bg-red-500 text-lg text-bg font-semibold rounded" onClick={handleRollbackClick}>Roll Back</button>
      <RollbackConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"