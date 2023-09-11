const MultiSelectHeader = (props) => {
  return (
    <div class="w-full p-2 bg-lightgray">
      { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
    </div>
  );
};

export default MultiSelectHeader;
