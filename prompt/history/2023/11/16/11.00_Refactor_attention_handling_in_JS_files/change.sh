#!/bin/sh
set -e
goal="Refactor attention handling in JS files"
echo "Plan:"
echo "1. Modify handleAttentionChange to call setAttention indirectly."
echo "2. Remove redundant setAttention calls in AttentionFileList.jsx."
echo "3. Ensure alignment with ES6, SolidJS, and coding standards."

# Modifying handleAttentionChange.js
cat > ./src/frontend/service/handleAttentionChange.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

export const handleAttentionChange = async (attention, setAttention) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ attention })
  });

  if (response.ok) {
    setAttention(attention);
  }

  return response.ok;
};
EOF
echo "Modified handleAttentionChange.js"

# Modifying AttentionFileList.jsx
cat > ./src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import { requirements } from '../model/requirements';
import { useAttention } from '../model/useAttention';
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange as handleAttentionChangeService } from '../service/handleAttentionChange';
import extractQuery from '../service/helpers/extractQuery';
import flattenPaths from '../service/helpers/flattenPaths';

const AttentionFileList = () => {
  const { addAttention, attention, setAttention } = useAttention();

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

  const onAttentionChange = async (newAttention) => {
    await handleAttentionChangeService(newAttention, setAttention);
  };

  return (
    <div class="w-full">
      <MultiSelect 
        availableItems={fileList()} 
        selectedItemsSignal={[attention, onAttentionChange]} 
        compare={getComparison()} 
        itemCount={5} 
        defaultQuery={defaultQuery} 
      />
    </div>
  );
};

export default AttentionFileList;
EOF
echo "Modified AttentionFileList.jsx"

echo "\033[32mDone: $goal\033[0m\n"