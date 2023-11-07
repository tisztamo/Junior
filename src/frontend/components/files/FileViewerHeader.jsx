import ListItem from '../MultiSelect/ListItem';
import { useAttention } from '../../model/useAttention'; // Fixed import

const FileViewerHeader = (props) => {
  const { addAttention } = useAttention();

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
      <button
        class="ml-4 text-lg bg-primary text-white py-2 px-4 rounded"
        onClick={() => addAttention(props.path)}
      >
        Add to Attention
      </button>
    </div>
  );
};

export default FileViewerHeader;
