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
