import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import { createSignal } from 'solid-js';

const FilteredList = (props) => {
  const [showPopup, setShowPopup] = createSignal(false);
  const [popupPath, setPopupPath] = createSignal('');

  const handleLongTap = (path) => {
    setPopupPath(path);
    setShowPopup(true);
  };

  return (
    <div>
      <ul class="list-inside">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={handleLongTap} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
