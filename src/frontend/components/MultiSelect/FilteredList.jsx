import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
import handleFilePopup from './handleFilePopup';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleFilePopup();

  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={invoke} />)}
      </ul>
      { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
