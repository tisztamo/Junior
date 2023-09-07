import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map(item => <ListItem key={item} item={item} />)}
    </ul>
  );
};

export default ResultSet;
