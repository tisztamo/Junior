#!/bin/sh
set -e
goal="Display path in FileViewer header"
echo "Plan:"
echo "1. Update FileViewerHeader to accept a path and display it using ListItem."
echo "2. Pass the path prop from FileViewer to FileViewerHeader."
echo "3. Ensure ListItem is exported correctly as it will be used in FileViewerHeader."

# Updating FileViewerHeader to accept a path and display it using ListItem
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import { createSignal } from 'solid-js';
import ListItem from '../MultiSelect/ListItem';

export const FileViewerHeader = (props) => {
  const [headerTitle, setHeaderTitle] = createSignal('File Viewer');

  return (
    <div class="flex justify-between items-center p-4 bg-gray-100">
      <h1 class="text-xl font-bold">{headerTitle()}</h1>
      <ListItem item={props.path} />
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

# Passing the path prop from FileViewer to FileViewerHeader
cat > ./src/frontend/components/files/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';
import { FileViewerHeader } from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50">
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg">
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

# Ensure ListItem is exported correctly
cat > ./src/frontend/components/MultiSelect/ListItem.jsx << 'EOF'
import { createEffect } from "solid-js";
import useLongTap from "./LongTapDetector";

const ListItem = (props) => {
  let pathRef;
  const uniqueId = `item-${Math.random().toString(36).substr(2, 9)}`;
  const longTapActions = useLongTap(() => props.onLongTap(props.item));

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item, uniqueId);
    }
  };

  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div id={uniqueId} onClick={handleClick} {...longTapActions} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"