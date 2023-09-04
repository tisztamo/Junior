import { createSignal } from "solid-js";

const FilteredListItem = (props) => {
  return (
    <div class="flex justify-between items-center w-full overflow-x-auto font-mono">
      <span>{props.item}</span>
      <span>{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
