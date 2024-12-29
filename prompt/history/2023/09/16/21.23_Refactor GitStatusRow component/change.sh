#!/bin/sh
set -e
goal="Refactor GitStatusRow component"
echo "Plan:"
echo "1. Split the path to extract filename and base directory."
echo "2. Concatenate index and working_dir fields for the first column."
echo "3. Render filename in the second column."
echo "4. Render base directory in the third column."
echo "5. Add styles to enable scrolling within cells."

# Modify the GitStatusRow component to fulfill the requirements
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;

  // Split the path to get filename and base directory
  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px overflow-x-auto">{index + ' ' + working_dir}</span>
      <span class="flex-grow w-60% overflow-x-auto">{fileName}</span>
      <span class="flex-shrink overflow-x-auto">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

echo "\033[32mDone: $goal\033[0m\n"