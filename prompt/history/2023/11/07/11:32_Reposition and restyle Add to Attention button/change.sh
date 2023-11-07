#!/bin/sh
set -e
goal="Reposition and restyle Add to Attention button"
echo "Plan:"
echo "1. Modify the layout in FileViewerHeader.jsx to adjust button positions and padding."
echo "2. Implement a plus sign icon for the Add to Attention button with appropriate alt text."
echo "3. Update the onClick event to close the viewer after adding to attention."
cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import ListItem from '../MultiSelect/ListItem';
import { useAttention } from '../../model/useAttention'; // Fixed import

const FileViewerHeader = (props) => {
  const { addAttention } = useAttention();

  // Function to handle adding to attention and closing the viewer
  const handleAddToAttentionAndClose = () => {
    addAttention(props.path);
    props.onClose();
  };

  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize pr-4" // Added right padding
        onClick={props.onClose}
        aria-label="Close"
      >
        &times;
      </button>
      <button
        class="text-3xl font-bold text-emphasize px-3" // Added horizontal padding
        onClick={handleAddToAttentionAndClose}
        aria-label="Add to Attention"
      >
        &#43; {/* Unicode for plus sign */}
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