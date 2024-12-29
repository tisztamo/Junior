#!/bin/sh
set -e
goal="Modify FileViewer structure and behavior"
echo "Plan:"
echo "1. Remove the empty div from the FileViewer component."
echo "2. Prevent the outer div of the FileViewer component from closing the viewer on click."
echo "3. Remove overflow-y-auto from the bg-white div in FileViewer component."
echo "4. Add a new wrapper around SourceFileDisplay to allow vertical scrolling."

# Step 1 & 2
cat > ./src/frontend/components/files/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';
import { FileViewerHeader } from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50">
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg">
          <FileViewerHeader onClose={props.onClose} />
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

echo "\033[32mDone: $goal\033[0m\n"