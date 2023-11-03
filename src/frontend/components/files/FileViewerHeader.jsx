import ListItem from '../MultiSelect/ListItem';

export const FileViewerHeader = (props) => {
  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize mr-auto"
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
