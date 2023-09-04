import FilteredListItem from "./FilteredListItem";

const FilteredList = (props) => {
  return (
    <ul class="list-decimal pl-5 list-inside">
      {props.items.map((item, idx) => <FilteredListItem key={item} item={item} idx={idx + 1} />)}
    </ul>
  );
};

export default FilteredList;
