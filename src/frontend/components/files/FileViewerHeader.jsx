import ListItem from '../MultiSelect/ListItem';
import { useAttention } from '../../model/useAttention';

const FileViewerHeader = (props) => {
  const { addAttention, removeAttention, isInAttention } = useAttention();

  const toggleAttention = () => {
    if (isInAttention(props.path)) {
      removeAttention(props.path);
    } else {
      addAttention(props.path);
    }
    props.onClose();
  };

  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize pr-4"
        onClick={props.onClose}
        aria-label="Close"
      >
        &times;
      </button>
      <button
        class="text-3xl font-bold text-emphasize px-3"
        onClick={toggleAttention}
        aria-label={isInAttention(props.path) ? "Remove from Attention" : "Add to Attention"}
      >
        {isInAttention(props.path) ? '−' : '+'} {/* Direct Unicode characters for minus/plus */}
      </button>
      <div class="flex-grow">
        <ListItem item={props.path} />
      </div>
    </div>
  );
};

export default FileViewerHeader;
