import ListItem from "./ListItem";
import handleUnselectItem from "./handleUnselectItem";

const ResultSet = (props) => {
  const handleItemClick = (item) => {
    handleUnselectItem(item, props.setSelectedItems, props.selectedItems);
  };

  return (
    <div>
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={handleItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;
