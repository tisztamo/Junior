const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
