const MultiSelectHeader = (props) => {
  return (
    <summary>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1 }}>
          { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
        </div>
        { props.items().length > 0 && 
          <span class="cursor-pointer ml-2" onClick={props.onClear}>
            🗑
          </span>
        }
      </div>
    </summary>
  );
};

export default MultiSelectHeader;
