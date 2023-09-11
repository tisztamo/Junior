#!/bin/sh
set -e
goal="Implement UI enhancements"
echo "Plan:"
echo "1. Remove padding from the left in both ResultSet and FilteredList components."
echo "2. Add vertical margin to the FilteredListItem."
echo "3. Add a lightweight border between the two spans in FilteredListItem."

# Step 1: Removing padding from the left in ResultSet and FilteredList components.

cat > src/frontend/components/MultiSelect/ResultSet.jsx << EOF
const ResultSet = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;
EOF

cat > src/frontend/components/MultiSelect/FilteredList.jsx << EOF
import FilteredListItem from "./FilteredListItem";

const FilteredList = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map((item, idx) => <FilteredListItem key={item} item={item} idx={idx + 1} />)}
    </ul>
  );
};

export default FilteredList;
EOF

# Step 2: Adding vertical margin to the FilteredListItem.

# Step 3: Adding a lightweight border between the two spans in FilteredListItem.

cat > src/frontend/components/MultiSelect/FilteredListItem.jsx << EOF
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
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap mr-4 border-r pr-2">{props.item}</span>
      <span>{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"