#!/bin/sh
set -e
goal="Refactor file list handling for commit refresh"
echo "Plan:"
echo "1. Refactor fetchFileList to handle file list setting"
echo "2. Simplify file list fetching in AttentionFileList"
echo "3. Update handleCommitService to refresh file list after commit"

# Update fetchFileList.js
cat > src/frontend/service/fetchFileList.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';
import { setFileList } from '../model/fileList';
import flattenPaths from './helpers/flattenPaths';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();

  // Handle data and update file list
  if (Array.isArray(data)) {
    const flattenedData = flattenPaths({
      type: "dir",
      name: ".",
      children: data
    }, '');
    setFileList(flattenedData);
  }
}

export default fetchFileList;
EOF

# Simplify AttentionFileList.jsx
cat > src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect } from 'solid-js';
import { fileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import { requirements } from '../model/requirements';
import { useAttention } from '../model/useAttention';
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange as handleAttentionChangeService } from '../service/handleAttentionChange';
import extractQuery from '../service/helpers/extractQuery';

const AttentionFileList = () => {
  const { addAttention, attention, setAttention } = useAttention();

  createEffect(() => {
    fetchFileList();
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

# Update handleCommitService.js
cat > src/frontend/service/lifecycle/handleCommitService.js << 'EOF'
import postCommit from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { tags } from '../../model/tagsModel';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';
import fetchFileList from '../fetchFileList';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage(), tags());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);

  // Refresh file list
  await fetchFileList();

  clearState();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"