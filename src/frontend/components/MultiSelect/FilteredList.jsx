import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import handleLongTap from './handleLongTap';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={invoke} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
