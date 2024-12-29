#!/bin/sh
set -e
goal="Implement MultiSelectHeader font and padding changes"
echo "Plan:"
echo "1. Modify the MultiSelectHeader.jsx to match the font of TaskList and add padding."
echo "2. Make sure to maintain the project specifics mentioned."

# Changing the MultiSelectHeader.jsx to match font and add padding to the summary and message.
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
    <summary style={{ padding: '0 1rem' }}>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1, padding: '0 1rem', fontFamily: 'inherit' }}>
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