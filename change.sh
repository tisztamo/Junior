#!/bin/sh
set -e
goal="Rename ConfirmationDialog, update properties, and style with Tailwind"
echo "Plan:"
echo "1. Rename ConfirmationDialog to RollbackConfirmationDialog"
echo "2. Update the bg-emphasize button background to a red color from Tailwind classes, and the label to 'Yes, Roll Back'"
echo "3. Add more space between the checkbox and its label using Tailwind classes"
echo "4. Update the RollbackButton component to use the new name RollbackConfirmationDialog and reflect changes"
echo "5. Ensure all the dependencies and references are updated to maintain coherence in the codebase"

# Step 1: Rename ConfirmationDialog to RollbackConfirmationDialog and make necessary changes
cat > src/frontend/components/RollbackConfirmationDialog.jsx <<EOF
import { createEffect, createSignal } from "solid-js";

const RollbackConfirmationDialog = (props) => {
  const [visible, setVisible] = createSignal(false);
  const [disableConfirmation, setDisableConfirmation] = createSignal(false);

  const handleCheckboxChange = (event) => {
    setDisableConfirmation(event.target.checked);
    localStorage.setItem('Junior.disableRollbackConfirmation', event.target.checked);
  };

  createEffect(() => {
    setVisible(props.visible);
  });

  return (
    <div className={visible() ? "block" : "hidden"}>
      <div className="fixed inset-0 flex items-center justify-center z-50" style={{ backgroundColor: "var(--background-color)" }}>
        <div className="bg-main p-8 rounded shadow-lg text-text">
          <h3 className="text-xl mb-4">Are you sure you want to roll back?</h3>
          <p>This will reset the repo to the last commit and delete new files.</p>
          <label className="flex items-center my-2">
            <input type="checkbox" className="mr-3" checked={disableConfirmation()} onChange={handleCheckboxChange} />
            Never show this again
          </label>
          <div>
            <button className="bg-red-500 text-white px-4 py-2 rounded mr-4" onClick={props.onConfirm}>Yes, Roll Back</button>
            <button className="bg-gray-400 text-white px-4 py-2 rounded" onClick={props.onCancel}>Cancel</button>
          </div>
        </div>
      </div>
      <div className={visible() ? "fixed inset-0 bg-black opacity-50" : "hidden"}></div>
    </div>
  );
};

export default RollbackConfirmationDialog;
EOF

# Step 2: Update RollbackButton component to use the new name RollbackConfirmationDialog
cat > src/frontend/components/RollbackButton.jsx <<EOF
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
      <button className="w-full px-4 py-4 bg-red-700 text-white rounded" onClick={handleRollbackClick}>Roll Back</button>
      <RollbackConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;
EOF

# Removing the old file
rm src/frontend/components/ConfirmationDialog.jsx

echo "\033[32mDone: $goal\033[0m\n"
