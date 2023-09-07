#!/bin/sh
set -e
goal="Implement multi-select list item modifications"
echo "Plan:"
echo "1. Adjust the JSX structure to show numbers on the left."
echo "2. Split the item text into filename and directory, and display them with the specified styles."

# Step 1: Adjust the JSX structure to show numbers on the left.
cat > src/frontend/components/MultiSelect/FilteredListItem.jsx << 'EOF'
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

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="border-r border-border pl-2 pr-2">{props.idx}</span>
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-xl">{filename}</span>
      <span class="ml-2">{directory}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"