#!/bin/sh
set -e
goal="Implement signal for filtered list using correct SolidJS methods"
echo "Plan:"
echo "1. Adjust imports in MultiSelect to ensure FilteredList is imported."
echo "2. Use createEffect in the MultiSelect component to compute the filtered list."
echo "3. Update FilteredList component to accept the computed filtered list as a prop."
echo "4. Ensure all components have the necessary imports and exports."

# Update MultiSelect component
cat > src/frontend/components/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);

  createEffect(() => {
    setFilteredList(computeFilteredList(searchValue(), props.availableItems, props.compare, props.itemCount));
  });

  return (
    <div class="w-full rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
EOF

# Update computeFilteredList.js to accept more parameters
cat > src/frontend/components/computeFilteredList.js << 'EOF'
export default function computeFilteredList(searchValue, items, compare, itemCount) {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  return items
    .filter(item => comparisonFunction(item, searchValue) > 0)
    .sort((a, b) => comparisonFunction(b, searchValue) - comparisonFunction(a, searchValue))
    .slice(0, itemCount);
}
EOF

# No changes to FilteredList component, as it was already simplified
# No changes to SearchBar component as it remains the same
# No need to change the ResultSet as it remains the same

echo "\033[32mDone: $goal\033[0m\n"