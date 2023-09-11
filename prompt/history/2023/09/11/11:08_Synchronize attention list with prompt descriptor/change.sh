#!/bin/sh
set -e
goal="Synchronize attention list with prompt descriptor"
echo "Plan:"
echo "1. Create a new service to fetch the attention field from the prompt descriptor."
echo "2. Update the AttentionFileList component to use this new service to set the attention model reactively."
echo "3. Ensure that all required imports are present in AttentionFileList component."

# 1. Create a service function to get the attention field from the prompt descriptor
cat > src/frontend/service/getAttentionFromDescriptor.js << 'EOF'
import { promptDescriptor } from '../model/promptDescriptor';
import { getYamlEntry } from './getYamlEntry';

export const getAttentionFromDescriptor = () => {
  const descriptor = promptDescriptor();
  if (descriptor !== '') {
    return getYamlEntry(descriptor, 'attention');
  }
  return [];
};
EOF

# 2. Update the AttentionFileList component to use this service function and ensure imports are correct
cat > src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';
import extractQuery from '../service/helpers/extractQuery';
import { requirements } from '../model/requirements';
import { attention, setAttention } from '../model/attentionModel';
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  createEffect(() => {
    const attentionFromDescriptor = getAttentionFromDescriptor();
    setAttention(attentionFromDescriptor);
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItemsSignal={[attention, setAttention]} compare={getComparison()} itemCount={5} defaultQuery={defaultQuery} />
    </div>
  );
};

export default AttentionFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"