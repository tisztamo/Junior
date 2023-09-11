#!/bin/sh
set -e
goal="Modify FilteredListItem.jsx UI components"
echo "Plan:"
echo "1. Update FilteredListItem.jsx by removing my-1 from div"
echo "2. Add py-2 to the first span in FilteredListItem.jsx"
echo "3. Add border-border to the second span in FilteredListItem.jsx"
echo "4. Save changes to FilteredListItem.jsx"

# Create the modified FilteredListItem.jsx
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
    <div class="flex justify-between items-center w-full font-mono">
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden mr-4 py-2">{props.item}</span>
      <span class="border-l border-border pl-2 pr-2">{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"