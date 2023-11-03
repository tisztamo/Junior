import ListItem from '../MultiSelect/ListItem';

const FileViewerHeader = (props) => {
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
    </div>
  );
};

export default FileViewerHeader;
