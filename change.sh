#!/bin/sh
set -e
goal="Add space to checkbox and label in ConfirmationDialog"
echo "Plan:"
echo "1. Add margin styles to the checkbox and label in ConfirmationDialog.jsx component to ensure spacing according to the requirements."
cat > src/frontend/components/ConfirmationDialog.jsx << 'EOF'
import { createEffect, createSignal } from "solid-js";

const ConfirmationDialog = (props) => {
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
          <label style={{ display: 'flex', alignItems: 'center', margin: '10px 0' }}>
            <input type="checkbox" style={{ marginRight: '10px' }} checked={disableConfirmation()} onChange={handleCheckboxChange} />
            Never show this again
          </label>
          <div>
            <button className="bg-emphasize text-white px-4 py-2 rounded mr-4" onClick={props.onConfirm}>Confirm</button>
            <button className="bg-gray-400 text-white px-4 py-2 rounded" onClick={props.onCancel}>Cancel</button>
          </div>
        </div>
      </div>
      <div className={visible() ? "fixed inset-0 bg-black opacity-50" : "hidden"}></div>
    </div>
  );
};

export default ConfirmationDialog;
EOF
echo "\033[32mDone: $goal\033[0m\n"
