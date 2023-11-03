#!/bin/sh
set -e
goal="Refactor FileViewer for transparent background and header layout"
echo "Plan:"
echo "1. Update FileViewer.jsx to set a 50% transparent gray background."
echo "2. Modify FileViewerHeader.jsx to remove the title and move the close button to the left."
echo "3. Wrap the list item in FileViewerHeader and make it fill the available width."

# Step 1: Update FileViewer.jsx for transparent background
cat > ./src/frontend/components/files/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';
import { FileViewerHeader } from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50 bg-gray-500 bg-opacity-50">
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

# Step 2 & 3: Modify FileViewerHeader.jsx to remove the title and adjust layout
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import ListItem from '../MultiSelect/ListItem';

export const FileViewerHeader = (props) => {
  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize mr-auto"
        onClick={props.onClose}
      >
        &times;
      </button>
      <div class="flex-grow">
        <ListItem item={props.path} />
      </div>
    </div>
  );
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
