#!/bin/sh
set -e
goal="Implement requested changes for FilteredListItem"
echo "Plan:"
echo "1. Remove the numbering from the FilteredListItem component."
echo "2. Modify the layout to prioritize the filename over the directory path."
echo "3. Ensure directory path is scrollable and is scrolled to the right on load."

# Removing numbering and making necessary layout changes
cat > src/frontend/components/MultiSelect/FilteredListItem.jsx << 'EOF'
import { createEffect } from "solid-js";

const FilteredListItem = (props) => {
  let pathRef;

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item);
    }
  };

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-xl">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2">{directory}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"