const ResultSet = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;
