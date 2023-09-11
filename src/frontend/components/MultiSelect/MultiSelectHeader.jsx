const MultiSelectHeader = (props) => {
  return (
    <summary class="w-full p-2">
      { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
    </summary>
  );
};

export default MultiSelectHeader;
