import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;
