#!/bin/sh
set -e
goal="Integrate MultiSelect with AttentionFileList"
echo "Plan:"
echo "1. Modify AttentionFileList to utilize MultiSelect for displaying the fileList."
echo "2. Remove the direct div generation from AttentionFileList and use MultiSelect to achieve the functionality."

# Modifying AttentionFileList.jsx to incorporate MultiSelect component.
cat << 'EOF' > src/frontend/components/AttentionFileList.jsx
import { onCleanup, createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

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

  onCleanup(() => {});

  return (
    <div class="border p-4">
      <MultiSelect availableItems={fileList().slice(0, 5)} selectedItems={[]} />  {/* GOAL OF THE CHANGE: Use MultiSelect for displaying the fileList */}
    </div>
  );
};

export default AttentionFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"