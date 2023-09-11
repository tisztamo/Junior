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
    <summary>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1 }}>
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
