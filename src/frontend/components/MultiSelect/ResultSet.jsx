import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import handleLongTap from './handleLongTap';

const ResultSet = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} onLongTap={invoke} />)}
        </ul>
      )}
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default ResultSet;
