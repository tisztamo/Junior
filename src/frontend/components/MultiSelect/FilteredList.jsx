import ListItem from "./ListItem";

const FilteredList = (props) => {
  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={props.onItemLongTap} />)}
      </ul>
    </div>
  );
};

export default FilteredList;
