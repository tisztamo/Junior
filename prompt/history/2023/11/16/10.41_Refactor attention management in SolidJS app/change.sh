#!/bin/sh
set -e
goal="Refactor attention management in SolidJS app"
echo "Plan:"
echo "1. Modify useAttention.js to return setAttention."
echo "2. Update AttentionFileList.jsx to include createSignal and use setAttention for bulk updates."
echo "3. Ensure compliance with project specifics and coding standards."

# Modifying useAttention.js
cat > ./src/frontend/model/useAttention.js << 'EOF'
import { attention, setAttention } from './attentionModel';

const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  const addAttention = (path) => {
    path = normalizePath(path);
    setAttention((prev) => [...prev, path]);
  };

  return { addAttention, attention, setAttention };
};

export { useAttention };
EOF

# Updating AttentionFileList.jsx
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
    if (await handleAttentionChangeService(newAttention)) {
      setAttention(newAttention);
    }
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

echo "\033[32mDone: $goal\033[0m\n"