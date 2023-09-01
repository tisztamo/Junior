const FilteredList = (props) => {
  return (
    <ul class="w-full list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).slice(0, props.itemCount).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
