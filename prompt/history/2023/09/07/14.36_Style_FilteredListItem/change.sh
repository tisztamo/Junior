#!/bin/sh
set -e
goal="Style FilteredListItem"
echo "Plan:"
echo "1. Update styles for the filename: set font to mono, 1em font size, bg-main background color, and rounded padding."
echo "2. Update styles for the path to make it a bit smaller."

# Update the FilteredListItem component styles according to the requirements
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
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"