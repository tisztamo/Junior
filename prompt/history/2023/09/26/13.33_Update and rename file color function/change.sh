#!/bin/sh
set -e
goal="Update and rename file color function"
echo "Plan:"
echo "1. Rename getBackgroundColorForFile.jsx to getStyleForFileStatus.jsx."
echo "2. Modify getStyleForFileStatus.jsx to return proper styling."
echo "3. Update GitStatusRow.jsx to use the new function and inline styles."

# 1. Rename getBackgroundColorForFile.jsx to getStyleForFileStatus.jsx
mv ./src/frontend/components/getBackgroundColorForFile.jsx ./src/frontend/components/getStyleForFileStatus.jsx

# 2. Modify getStyleForFileStatus.jsx
cat > ./src/frontend/components/getStyleForFileStatus.jsx << 'EOF'
export default function getStyleForFileStatus(index, path) {
  if (index === 'M') {
    return { backgroundColor: 'rgb(34, 197, 94)' };
  } else if (index === 'A' && !path.includes('prompt/history')) {
    return { backgroundColor: 'rgb(253, 186, 116)' };
  }
  return {}; // Default no background style
}
EOF

# 3. Update GitStatusRow.jsx
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import { createEffect } from "solid-js";
import getStyleForFileStatus from './getStyleForFileStatus';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const { onClick } = props;

  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgStyle = getStyleForFileStatus(index, path);

  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  return (
    <div class="flex" style={bgStyle} onClick={() => onClick(path)}>
      <span class="w-50px overflow-x-auto p-1">{index + ' ' + working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

echo "\033[32mDone: $goal\033[0m\n"