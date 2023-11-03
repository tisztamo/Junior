import { createSignal } from 'solid-js';

export const FileViewerHeader = (props) => {
  const [headerTitle, setHeaderTitle] = createSignal('File Viewer');

  return (
    <div class="flex justify-between items-center p-4 bg-gray-100">
      <h1 class="text-xl font-bold">{headerTitle()}</h1>
      <button
        class="text-3xl font-bold text-gray-600 hover:text-gray-800"
        onClick={props.onClose}
      >
        &times;
      </button>
    </div>
  );
};
