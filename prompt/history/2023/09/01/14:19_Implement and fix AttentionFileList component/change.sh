#!/bin/sh
set -e
goal="Implement and fix AttentionFileList component"
echo "Plan:"
echo "1. Create model/fileList.js to manage the file list state"
echo "2. Create service/fetchFileList.js to fetch the file list"
echo "3. Create AttentionFileList.jsx to display the files in the format described"
echo "4. Update components/PromptCreation.jsx to include the new component after RequirementsEditor"
echo "5. Apply a fix to AttentionFileList.jsx to handle nodes without children"

# Step 1: Create model/fileList.js
cat << 'EOF' > src/frontend/model/fileList.js
import { createSignal } from 'solid-js';

const [fileList, setFileList] = createSignal([]);
export { fileList, setFileList };
EOF
echo "1. Created model/fileList.js"

# Step 2: Create service/fetchFileList.js
cat << 'EOF' > src/frontend/service/fetchFileList.js
import { getBaseUrl } from '../getBaseUrl';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();
  return data;
};

export default fetchFileList;
EOF
echo "2. Created service/fetchFileList.js"

# Step 3: Create AttentionFileList.jsx
cat << 'EOF' > src/frontend/components/AttentionFileList.jsx
import { onCleanup, createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';

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
    // Check if children exists and is an array
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
      {fileList().map(file => <div>{file}</div>)}
    </div>
  );
};

export default AttentionFileList;
EOF
echo "3. Created and fixed AttentionFileList.jsx"

# Step 4: Update components/PromptCreation.jsx
cat << 'EOF' > src/frontend/components/PromptCreation.jsx
import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <AttentionFileList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;
EOF
echo "4. Updated components/PromptCreation.jsx"

echo "\033[32mDone: $goal\033[0m\n"