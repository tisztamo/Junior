const ResultSet = (props) => {
  return (
    <ul class="list-decimal pl-5 list-inside">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;
