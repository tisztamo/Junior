const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items
        // Filter by non-zero ranks.
        .filter(item => comparisonFunction(item, props.filter) > 0)
        // Sort items by rank, highest rank first.
        .sort((a, b) => comparisonFunction(b, props.filter) - comparisonFunction(a, props.filter))
        .slice(0, props.itemCount)
        .map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
