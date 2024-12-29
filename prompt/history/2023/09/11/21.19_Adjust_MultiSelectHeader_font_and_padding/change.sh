#!/bin/sh
set -e
goal="Adjust MultiSelectHeader font and padding"
echo "Plan:"
echo "1. Update MultiSelectHeader.jsx to have slight padding adjustments and increase font size."
echo "2. Keep the project specifics in mind during the adjustments."

# Updating the MultiSelectHeader.jsx to adjust the padding and font size.
cat > ./src/frontend/components/MultiSelect/MultiSelectHeader.jsx << 'EOF'
const MultiSelectHeader = (props) => {
  const handleClearClick = async (event) => {
    event.preventDefault(); // This prevents the details tag from being switched
    props.onClear();
  };

  const attentionFileCountMessage = (fileCount) => {
    if (fileCount === 1) {
      return '1 file in attention';
    }
    return `${fileCount} files in attention`;
  };

  return (
    <summary style={{ padding: '0 0.5rem' }}>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1, padding: '0 0.5rem', fontFamily: 'inherit', fontSize: '1.2em' }}>
          { props.items().length > 0 ? attentionFileCountMessage(props.items().length) : props.emptyMessage }
        </div>
        { props.items().length > 0 && 
          <a href="#" class="cursor-pointer ml-2 text-blue-500" onClick={handleClearClick}>
            clear
          </a>
        }
      </div>
    </summary>
  );
};

export default MultiSelectHeader;
EOF

echo "\033[32mDone: $goal\033[0m\n"