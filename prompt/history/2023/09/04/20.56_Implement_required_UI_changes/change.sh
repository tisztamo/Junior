#!/bin/sh
set -e
goal="Implement required UI changes"
echo "Plan:"
echo "1. Update styles in MultiSelect.jsx to make padding smaller."
echo "2. Update styles in SearchBar.jsx to add vertical margin and adjust border."
echo "3. Update styles in ResultSet.jsx to hide the discs."
echo "4. Update styles in FilteredList to hide the discs."

# 1. Update styles in MultiSelect.jsx to make padding smaller.
cat <<EOF >src/frontend/components/MultiSelect/MultiSelect.jsx
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
    setFilteredList(computeFilteredList(searchValue(), props.availableItems, props.compare, props.itemCount));
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

# 2. Update styles in SearchBar.jsx to add vertical margin and adjust border.
cat <<EOF >src/frontend/components/MultiSelect/SearchBar.jsx
const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      props.addFirstFilteredItem();
    }
  };

  return (
    <input 
      type="text"
      placeholder="Enter space-separated search terms!"
      value={props.searchValue()}
      onInput={handleInputChange}
      onKeyPress={handleKeyPress}
      class="border border-gray-300 rounded p-2 w-full bg-emphasize text-emphasize my-2"
    />
  );
};

export default SearchBar;
EOF

# 3. Update styles in ResultSet.jsx to hide the discs.
cat <<EOF >src/frontend/components/MultiSelect/ResultSet.jsx
const ResultSet = (props) => {
  return (
    <ul class="list-decimal pl-5 list-inside">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;
EOF

# 4. Update styles in FilteredList to hide the discs.
cat <<EOF >src/frontend/components/MultiSelect/FilteredList.jsx
const FilteredList = (props) => {
  return (
    <ul class="list-decimal pl-5 list-inside">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"