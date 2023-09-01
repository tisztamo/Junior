const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter));
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items
        .filter(item => comparisonFunction(item, props.filter))
        .slice(0, props.itemCount)
        .map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
