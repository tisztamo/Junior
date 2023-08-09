#!/bin/sh
set -e
goal="Implement rollback confirmation for reset functionality"
echo "Plan:"
echo "1. Create a new Solidjs component to handle the rollback confirmation."
echo "2. Update the RollbackButton.jsx to include the new confirmation logic."

# Create a new file for the confirmation dialog
cat > src/frontend/components/ConfirmationDialog.jsx << 'EOF'
import { createEffect, createSignal } from "solid-js";

const ConfirmationDialog = (props) => {
  const [visible, setVisible] = createSignal(false);

  createEffect(() => {
    setVisible(props.visible);
  });

  return (
    <div className={visible() ? "block" : "hidden"}>
      <div className="fixed inset-0 flex items-center justify-center z-50">
        <div className="bg-white p-8 rounded shadow-lg">
          <p>Are you sure you want to roll back? This will reset the repo to the last commit and delete new files.</p>
          <button className="bg-red-700 text-white px-4 py-2 rounded mr-4" onClick={props.onConfirm}>Confirm</button>
          <button className="bg-gray-400 text-white px-4 py-2 rounded" onClick={props.onCancel}>Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default ConfirmationDialog;
EOF

# Update RollbackButton.jsx file
cat > src/frontend/components/RollbackButton.jsx << 'EOF'
import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import ConfirmationDialog from './ConfirmationDialog';

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
    setShowConfirmation(true);
  };

  return (
    <>
      <button className="w-full px-4 py-4 bg-red-700 text-white rounded" onClick={handleRollbackClick}>Roll Back</button>
      <ConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"
