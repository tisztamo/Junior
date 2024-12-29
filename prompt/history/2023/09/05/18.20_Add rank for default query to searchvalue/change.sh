#!/bin/sh
set -e
goal="Add rank for default query to searchvalue"
echo "Plan:"
echo "1. Create a new file computeRank.js which will contain the computeRank function."
echo "2. Modify the computeFilteredList to use computeRank from the new file."
echo "3. Adjust MultiSelect.jsx to pass defaultQuery as an argument to computeFilteredList."

# Step 1: Create a new file computeRank.js
cat > src/frontend/components/MultiSelect/computeRank.js <<EOF
const computeRank = (item, searchValue, defaultQuery, comparisonFunction) => {
  const searchValueRank = comparisonFunction(item, searchValue);
  const defaultQueryRank = comparisonFunction(item, defaultQuery);
  return searchValueRank + defaultQueryRank;
};

export default computeRank;
EOF

# Step 2: Modify the computeFilteredList function
cat > src/frontend/components/MultiSelect/computeFilteredList.js <<EOF
import computeRank from './computeRank';

export default function computeFilteredList(searchValue, items, compare, itemCount, selectedItems = [], defaultQuery = "") {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return items
    .filter(item => !selectedItems.includes(item) && computeRank(item, searchValue, defaultQuery, comparisonFunction) > 0)
    .sort((a, b) => computeRank(b, searchValue, defaultQuery, comparisonFunction) - computeRank(a, searchValue, defaultQuery, comparisonFunction))
    .slice(0, itemCount);
}
EOF

# Step 3: Adjust MultiSelect.jsx to pass defaultQuery as an argument to computeFilteredList
cat > src/frontend/components/MultiSelect/MultiSelect.jsx <<EOF
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
    const currentQuery = searchValue() || props.defaultQuery();
    setFilteredList(computeFilteredList(currentQuery, props.availableItems, props.compare, props.itemCount, selectedItems(), props.defaultQuery()));
  });

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      const updatedItems = [filteredList()[0], ...selectedItems()];
      setSelectedItems(updatedItems);
    }
  };

  const handleItemClick = (item) => {
    const updatedItems = [item, ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleItemClick} />
    </div>
  );
};

export default MultiSelect;
EOF

echo "\033[32mDone: $goal\033[0m\n"