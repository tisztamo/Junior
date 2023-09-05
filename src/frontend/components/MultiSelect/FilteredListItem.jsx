import { createEffect } from "solid-js";

const FilteredListItem = (props) => {
  let itemRef;

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item);
    }
  };

  createEffect(() => {
    if (itemRef) {
      itemRef.scrollLeft = itemRef.scrollWidth;
    }
  });

  return (
    <div onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden mr-4 py-2">{props.item}</span>
      <span class="border-l border-border pl-2 pr-2">{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
