const ResultSet = (props) => {
  return (
    <ul class="list-disc pl-5">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;
