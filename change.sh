#!/bin/sh
set -e
goal="Make the dialog theme-aware with defined colors"
echo "Plan:"
echo "1. Update ConfirmationDialog.jsx to use the CSS variables defined in colors.css"
echo "2. Update the Tailwind configuration to reflect any new color definitions if needed"
echo "3. Ensure that the styles adapt based on the user's theme preference"

# Step 1: Update ConfirmationDialog.jsx to use the CSS variables defined in colors.css
cat << 'EOF' > src/frontend/components/ConfirmationDialog.jsx
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
          <label>
            <input type="checkbox" checked={disableConfirmation()} onChange={handleCheckboxChange} />
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
