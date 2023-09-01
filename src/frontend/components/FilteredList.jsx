const FilteredList = (props) => {
  return (
    <ul class="list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
