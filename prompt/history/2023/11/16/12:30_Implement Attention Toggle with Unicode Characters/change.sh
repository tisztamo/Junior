#!/bin/sh
set -e
goal="Implement Attention Toggle with Unicode Characters"
echo "Plan:"
echo "1. Update useAttention.js with check and remove functionality."
echo "2. Modify FileViewerHeader.jsx to include Unicode characters directly in the source."
echo "3. Ensure proper toggling between add and remove functionality."
echo "4. Test to confirm correct behavior."

# Updating useAttention.js
cat > ./src/frontend/model/useAttention.js << 'EOF'
import { handleAttentionChange } from '../service/handleAttentionChange';
import { attention, setAttention } from './attentionModel';

const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  const addAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = [...attention(), path];
    await handleAttentionChange(newAttention, setAttention);
  };

  const removeAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = attention().filter(item => item !== path);
    await handleAttentionChange(newAttention, setAttention);
  };

  const isInAttention = (path) => {
    path = normalizePath(path);
    return attention().includes(path);
  };

  return { addAttention, removeAttention, isInAttention, attention, setAttention };
};

export { useAttention };
EOF

# Updating FileViewerHeader.jsx
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import ListItem from '../MultiSelect/ListItem';
import { useAttention } from '../../model/useAttention';

const FileViewerHeader = (props) => {
  const { addAttention, removeAttention, isInAttention } = useAttention();

  const toggleAttention = () => {
    if (isInAttention(props.path)) {
      removeAttention(props.path);
    } else {
      addAttention(props.path);
    }
    props.onClose();
  };

  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize pr-4"
        onClick={props.onClose}
        aria-label="Close"
      >
        &times;
      </button>
      <button
        class="text-3xl font-bold text-emphasize px-3"
        onClick={toggleAttention}
        aria-label={isInAttention(props.path) ? "Remove from Attention" : "Add to Attention"}
      >
        {isInAttention(props.path) ? '−' : '+'} {/* Direct Unicode characters for minus/plus */}
      </button>
      <div class="flex-grow">
        <ListItem item={props.path} />
      </div>
    </div>
  );
};

export default FileViewerHeader;
EOF

echo "\033[32mDone: $goal\033[0m\n"
