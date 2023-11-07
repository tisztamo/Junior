#!/bin/sh
set -e
goal="Fix ReferenceError in AttentionFileList.jsx"
echo "Plan:"
echo "1. Add ES6 import statements for extractQuery and flattenPaths."
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
import extractQuery from '../service/helpers/extractQuery'; // Importing extractQuery
import flattenPaths from '../service/helpers/flattenPaths'; // Importing flattenPaths

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