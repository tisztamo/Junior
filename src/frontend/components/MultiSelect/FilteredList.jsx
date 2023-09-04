import FilteredListItem from "./FilteredListItem";

const FilteredList = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map((item, idx) => <FilteredListItem key={item} item={item} idx={idx + 1} />)}
    </ul>
  );
};

export default FilteredList;
