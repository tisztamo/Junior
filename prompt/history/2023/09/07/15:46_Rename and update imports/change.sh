#!/bin/sh
set -e
goal="Rename and update imports"
echo "Plan:"
echo "1. Rename FilteredListItem.jsx to ListItem.jsx."
echo "2. Update FilteredListItem component to ListItem."
echo "3. Update ResultSet to use ListItem."
echo "4. Update imports in FilteredList and ResultSet."

# 1. Rename FilteredListItem.jsx to ListItem.jsx
mv src/frontend/components/MultiSelect/FilteredListItem.jsx src/frontend/components/MultiSelect/ListItem.jsx

# 2. Update FilteredListItem component to ListItem
cat << 'EOF' > src/frontend/components/MultiSelect/ListItem.jsx
import { createEffect } from "solid-js";

const ListItem = (props) => {
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

export default ListItem;
EOF

# 3. Update ResultSet to use ListItem
cat << 'EOF' > src/frontend/components/MultiSelect/ResultSet.jsx
import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map(item => <ListItem key={item} item={item} />)}
    </ul>
  );
};

export default ResultSet;
EOF

# 4. Update imports in FilteredList
cat << 'EOF' > src/frontend/components/MultiSelect/FilteredList.jsx
import ListItem from "./ListItem";

const FilteredList = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} />)}
    </ul>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"