#!/bin/sh
set -e
goal="Implement styles and scrolling for git status filename and dir"
echo "Plan:"
echo "1. Modify GitStatusRow.jsx to set styles for filename and dir similar to ListItem.jsx."
echo "2. Incorporate the scrolling logic from ListItem to GitStatusRow."
echo "3. Adjust the styles to meet the given requirements."

# Step 1, 2 & 3: Modify GitStatusRow.jsx
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import { createEffect } from "solid-js";
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;

  // Split the path to get filename and base directory
  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);

  let pathRef; // For scrolling logic

  createEffect(() => { // Incorporate scrolling logic
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  // Adjusting styles and incorporating scrolling logic as per ListItem.jsx
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px overflow-x-auto p-1">{index + ' ' + working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

echo "\033[32mDone: $goal\033[0m\n"