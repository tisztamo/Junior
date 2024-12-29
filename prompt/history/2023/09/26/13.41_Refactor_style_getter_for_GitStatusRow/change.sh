#!/bin/sh
set -e
goal="Refactor style getter for GitStatusRow"
echo "Plan:"
echo "1. Modify getStyleForFileStatus to accept and utilize working_dir."
echo "2. Update the function to return text color styles."
echo "3. Update GitStatusRow component to pass working_dir to the style getter."

# Update getStyleForFileStatus.jsx
cat > ./src/frontend/components/getStyleForFileStatus.jsx << 'EOF'
export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'rgb(34, 197, 94)' };
  } else if (working_dir === 'A' && !path.includes('prompt/history')) {
    return { color: 'rgb(253, 186, 116)' };
  }
  return {}; // Default no text color style
}
EOF

# Update GitStatusRow.jsx to pass working_dir to style getter
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import { createEffect } from "solid-js";
import getStyleForFileStatus from './getStyleForFileStatus';

const GitStatusRow = (props) => {
  const { path, working_dir } = props.entry;
  const { onClick } = props;

  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const textStyle = getStyleForFileStatus(working_dir, path);

  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  return (
    <div class="flex" style={textStyle} onClick={() => onClick(path)}>
      <span class="w-50px overflow-x-auto p-1">{working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

echo "\033[32mDone: $goal\033[0m\n"