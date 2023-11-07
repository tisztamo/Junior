#!/bin/sh
set -e
goal="Provide attention signal via useAttention and add normalization"
echo "Plan:"
echo "1. Update useAttention.js to export the attention signal."
echo "2. Include path normalization within the useAttention hook."
echo "3. Update AttentionFileList.jsx to consume the attention signal from useAttention."

# Step 1: Update useAttention.js to include path normalization and export the attention signal
cat > ./src/frontend/model/useAttention.js << 'EOF'
import { attention, setAttention } from './attentionModel';

// Function to normalize the path
const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  // Function to add a path to the attention list with normalization
  const addAttention = (path) => {
    path = normalizePath(path); // Normalize the path
    setAttention((prev) => [...prev, path]);
  };

  // Return both the action and the signal
  return { addAttention, attention };
};

export { useAttention };
EOF

# Step 2: Update AttentionFileList.jsx to use the normalized addAttention function and attention signal from the useAttention hook
cat > ./src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import { requirements } from '../model/requirements';
import { useAttention } from '../model/useAttention'; // Importing the updated useAttention hook
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange as handleAttentionChangeService } from '../service/handleAttentionChange';

const AttentionFileList = () => {
  const { addAttention, attention } = useAttention(); // Using the updated useAttention hook

  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  createEffect(() => {
    const attentionFromDescriptor = getAttentionFromDescriptor();
    attentionFromDescriptor.forEach(path => addAttention(path)); // Using addAttention from the updated hook
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  const onAttentionChange = async (newAttention) => {
    if (await handleAttentionChangeService(newAttention)) {
      newAttention.forEach(path => addAttention(path)); // Using addAttention from the updated hook
    }
  };

  return (
    <div class="w-full">
      <MultiSelect 
        availableItems={fileList()} 
        selectedItemsSignal={[attention, onAttentionChange]} // Using the attention signal from the updated hook
        compare={getComparison()} 
        itemCount={5} 
        defaultQuery={defaultQuery} 
      />
    </div>
  );
};

export default AttentionFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"