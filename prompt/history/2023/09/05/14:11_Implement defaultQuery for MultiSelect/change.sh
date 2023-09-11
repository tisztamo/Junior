#!/bin/sh
set -e
goal="Implement defaultQuery for MultiSelect"
echo "Plan:"
echo "1. Create the extractQuery function in service/helpers/extractQuery.js."
echo "2. Modify the AttentionFileList.jsx component to use createEffect for changes in the requirements model."
echo "3. Pass the generated query to MultiSelect as defaultQuery prop."

# Step 1: Create the extractQuery function in service/helpers/extractQuery.js.
cat << EOF > src/frontend/service/helpers/extractQuery.js
const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
  return requirements.split(/\W+/)
    .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
    .join(' ');
}
EOF

# Step 2: Modify the AttentionFileList.jsx component
cat << EOF > src/frontend/components/AttentionFileList.jsx
import { createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';
import extractQuery from '../service/helpers/extractQuery';
import { requirements } from '../model/requirements';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  let defaultQuery = "";

  createEffect(() => {
    defaultQuery = extractQuery(requirements());
  });

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItems={[]} compare={getComparison()} itemCount={5} defaultQuery={defaultQuery} />
    </div>
  );
};

export default AttentionFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"