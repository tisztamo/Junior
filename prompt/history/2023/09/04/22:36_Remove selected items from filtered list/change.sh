#!/bin/sh
set -e
goal="Remove selected items from filtered list"
echo "Plan:"
echo "1. Modify the computeFilteredList function to remove already selected items from its output."
echo "2. Update the MultiSelect component to pass the selectedItems to the computeFilteredList function."

# Step 1: Modify the computeFilteredList function
cat > src/frontend/components/MultiSelect/computeFilteredList.js << 'EOF'
export default function computeFilteredList(searchValue, items, compare, itemCount, selectedItems = []) {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  return items
    .filter(item => !selectedItems.includes(item) && comparisonFunction(item, searchValue) > 0)
    .sort((a, b) => comparisonFunction(b, searchValue) - comparisonFunction(a, searchValue))
    .slice(0, itemCount);
}
EOF

# Step 2: Update the MultiSelect component
cat > src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);
  const [selectedItems, setSelectedItems] = createSignal([...props.selectedItems]);

  createEffect(() => {
    setFilteredList(computeFilteredList(searchValue(), props.availableItems, props.compare, props.itemCount, selectedItems()));
  });

  const addFirstFilteredItem = () => {
    const updatedItems = [filteredList()[0], ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} addFirstFilteredItem={addFirstFilteredItem} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
EOF

echo "\033[32mDone: $goal\033[0m\n"