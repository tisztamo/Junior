#!/bin/sh
set -e
goal="Enhance FileViewer with a header and close functionality"
echo "Plan:"
echo "1. Remove empty divs from FileViewer.jsx"
echo "2. Create a new Header component with a close button"
echo "3. Integrate the Header component into FileViewer.jsx"
echo "4. Ensure all changes follow the project specifics"

# Remove empty divs from FileViewer.jsx
sed -i '/<div class="absolute top-4 right-4" onClick={props.onClose}><\/div>/d' ./src/frontend/components/files/FileViewer.jsx

# Create the Header component
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
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
EOF

# Update FileViewer.jsx to include the new Header component
sed -i "s|import SourceFileDisplay from '../files/SourceFileDisplay';|import SourceFileDisplay from '../files/SourceFileDisplay';\nimport { FileViewerHeader } from './FileViewerHeader';|" ./src/frontend/components/files/FileViewer.jsx
sed -i "s|<div class=\"bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto\">|<div class=\"bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto\">\n          <FileViewerHeader onClose={props.onClose} />|" ./src/frontend/components/files/FileViewer.jsx

echo "\033[32mDone: $goal\033[0m\n"