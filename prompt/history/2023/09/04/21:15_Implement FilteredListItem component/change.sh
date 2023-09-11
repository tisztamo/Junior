#!/bin/sh
set -e
goal="Implement FilteredListItem component"
echo "Plan:"
echo "1. Create a new FilteredListItem.jsx that contains the desired layout and behavior."
echo "2. Import the FilteredListItem component into FilteredList.jsx."
echo "3. Modify the mapping in FilteredList to pass the correct props to FilteredListItem."

# Create the FilteredListItem component
cat > src/frontend/components/MultiSelect/FilteredListItem.jsx << 'EOF'
import { createSignal } from "solid-js";

const FilteredListItem = (props) => {
  return (
    <div class="flex justify-between items-center w-full overflow-x-auto font-mono">
      <span>{props.item}</span>
      <span>{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;
EOF

# Modify the FilteredList.jsx to use the new component
cat > src/frontend/components/MultiSelect/FilteredList.jsx << 'EOF'
import FilteredListItem from "./FilteredListItem";

const FilteredList = (props) => {
  return (
    <ul class="list-decimal pl-5 list-inside">
      {props.items.map((item, idx) => <FilteredListItem key={item} item={item} idx={idx + 1} />)}
    </ul>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"