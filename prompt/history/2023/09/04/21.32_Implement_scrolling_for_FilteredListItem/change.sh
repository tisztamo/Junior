#!/bin/sh
set -e

goal="Implement scrolling for FilteredListItem"
echo "Plan:"
echo "1. Modify FilteredListItem to separate the spans with margin."
echo "2. Add CSS to allow scrolling only for the item span."
echo "3. Implement JS functionality to auto-scroll the item span when the item prop changes."

# Step 1 and 2: Modify FilteredListItem
cat > src/frontend/components/MultiSelect/FilteredListItem.jsx <<EOF
import { createEffect } from "solid-js";

const FilteredListItem = (props) => {
  let itemRef;

  createEffect(() => {
    if (itemRef) {
      itemRef.scrollLeft = itemRef.scrollWidth;
    }
  });

  return (
    <div class="flex justify-between items-center w-full font-mono">
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap mr-4">{props.item}</span>
      <span>{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"