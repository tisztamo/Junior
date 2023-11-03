#!/bin/sh
set -e
goal="Refactor FileViewer components for styling updates"
echo "Refactor FileViewer components for styling updates"
echo "Plan:"
echo "1. Update the FileViewerHeader.jsx to change class bg-gray-100 to bg-emphasize and text-gray-600 to text-emphasize, and remove hover:text-gray-800."
echo "2. Update the FileViewer.jsx to change the class bg-white to bg-emphasize and h-3/4 to max-h-3/4."

# Updating FileViewerHeader.jsx
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import { createSignal } from 'solid-js';
import ListItem from '../MultiSelect/ListItem';

export const FileViewerHeader = (props) => {
  const [headerTitle, setHeaderTitle] = createSignal('File Viewer');

  return (
    <div class="flex justify-between items-center p-4 bg-emphasize">
      <h1 class="text-xl font-bold">{headerTitle()}</h1>
      <ListItem item={props.path} />
      <button
        class="text-3xl font-bold text-emphasize"
        onClick={props.onClose}
      >
        &times;
      </button>
    </div>
  );
};
EOF
echo "Updated FileViewerHeader.jsx"

# Updating FileViewer.jsx
cat > ./src/frontend/components/files/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';
import { FileViewerHeader } from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50">
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-emphasize w-full mx-2 max-h-3/4 rounded-lg">
          <FileViewerHeader onClose={props.onClose} path={props.path} />
          <div class="overflow-y-auto h-full">
            <SourceFileDisplay path={props.path} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
EOF
echo "Updated FileViewer.jsx"

echo "\033[32mDone: $goal\033[0m\n"