#!/bin/sh
set -e
goal="Enhance FilteredListItem styling and behavior"
echo "Plan:"
echo "1. Update the FilteredListItem component to not allow word wrap, add the break-keep class, never show scrollbars, and leave more space between the number and the vertical border."

# Implementing the plan
cat > src/frontend/components/MultiSelect/FilteredListItem.jsx << 'EOF'
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
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden mr-4">{props.item}</span>
      <span class="border-l pl-2 pr-2">{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"