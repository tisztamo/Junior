#!/bin/sh
set -e
goal="Refactor code structure and update imports"
echo "Plan:"
echo "1. Create service/helpers/ directory"
echo "2. Move getComparison to service/helpers/ directory"
echo "3. Factor out flattenPaths to service/helpers/"
echo "4. Update AttentionFileList.jsx imports accordingly"
echo "5. Delete services/ directory"

# Step 1: Create service/helpers/ directory
mkdir -p src/frontend/service/helpers/

# Step 2: Move getComparison to service/helpers/ directory
mv src/frontend/services/helpers/getComparison.js src/frontend/service/helpers/getComparison.js

# Step 3: Factor out flattenPaths to service/helpers/
cat << EOF > src/frontend/service/helpers/flattenPaths.js
const flattenPaths = (node, path) => {
  if (node.type === 'file') {
    return [path + '/' + node.name];
  }
  if (!Array.isArray(node.children)) {
    return [];
  }
  return node.children.reduce((acc, child) => {
    return acc.concat(flattenPaths(child, path + '/' + node.name));
  }, []);
};

export default flattenPaths;
EOF

# Step 4: Update AttentionFileList.jsx imports accordingly
cat << EOF > src/frontend/components/AttentionFileList.jsx
import { createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItems={[]} compare={getComparison()} itemCount={5} />
    </div>
  );
};

export default AttentionFileList;
EOF

# Step 5: Delete services/ directory
rm -r src/frontend/services/

echo "\033[32mDone: $goal\033[0m\n"