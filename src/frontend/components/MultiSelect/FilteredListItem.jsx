import { createEffect } from "solid-js";

const FilteredListItem = (props) => {
  let itemRef;

  createEffect(() => {
    if (itemRef) {
      itemRef.scrollLeft = itemRef.scrollWidth;
    }
  });

  return (
    <div class="flex justify-between items-center w-full font-mono my-1">
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap mr-2">{props.item}</span>
      <span class="border-l pl-1 pr-1">{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
