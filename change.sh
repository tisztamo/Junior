#!/bin/sh
set -e
goal="Enhance confirmation dialog visibility and add fade effect"
echo "Plan:"
echo "1. Modify the ConfirmationDialog component to separate the confirmation question from the rest of the text."
echo "2. Add a fade effect to the UI outside of the dialog while it is opened."

echo "Modifying ConfirmationDialog component for better visibility"
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
          <h3 className="text-xl mb-4">Are you sure you want to roll back?</h3>
          <p>This will reset the repo to the last commit and delete new files.</p>
          <button className="bg-red-700 text-white px-4 py-2 rounded mr-4" onClick={props.onConfirm}>Confirm</button>
          <button className="bg-gray-400 text-white px-4 py-2 rounded" onClick={props.onCancel}>Cancel</button>
        </div>
      </div>
      <div className={visible() ? "fixed inset-0 bg-black opacity-50" : "hidden"}></div>
    </div>
  );
};

export default ConfirmationDialog;
EOF

echo "\033[32mDone: $goal\033[0m\n"
