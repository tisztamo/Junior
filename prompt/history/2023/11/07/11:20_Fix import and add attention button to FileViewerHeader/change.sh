#!/bin/sh
set -e
goal="Fix import and add attention button to FileViewerHeader"
echo "Plan:"
echo "1. Create a new file useAttention.js to export the useAttention function."
echo "2. Update FileViewerHeader.jsx to import useAttention from the new file."
echo "3. Modify the FileViewerHeader component to include the attention button."

# Step 1: Create useAttention.js to export useAttention function.
cat > ./src/frontend/model/useAttention.js << 'EOF'
import { attention, setAttention } from './attentionModel';

const useAttention = () => {
  const addAttention = (path) => {
    setAttention((prev) => [...prev, path]);
  };

  return { addAttention };
};

export { useAttention };
EOF

# Step 2: Update the FileViewerHeader.jsx to use the new useAttention hook.
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import ListItem from '../MultiSelect/ListItem';
import { useAttention } from '../../model/useAttention'; // Fixed import

const FileViewerHeader = (props) => {
  const { addAttention } = useAttention();

  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize mr-auto pr-2"
        onClick={props.onClose}
      >
        &times;
      </button>
      <div class="flex-grow">
        <ListItem item={props.path} />
      </div>
      <button
        class="ml-4 text-lg bg-primary text-white py-2 px-4 rounded"
        onClick={() => addAttention(props.path)}
      >
        Add to Attention
      </button>
    </div>
  );
};

export default FileViewerHeader;
EOF

echo "\033[32mDone: $goal\033[0m\n"
