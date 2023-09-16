#!/bin/sh
set -e
goal="Fix horizontal layout with flex"
echo "Plan:"
echo "1. Replace grid layout with flexbox in GitStatusRow.jsx"
echo "2. Retain the width values as provided in the current version."

# Modify GitStatusRow.jsx with flex layout and width properties
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px">{index}</span>
      <span class="flex-grow w-60%">{path}</span>
      <span class="flex-shrink">{working_dir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

echo "\033[32mDone: $goal\033[0m\n"