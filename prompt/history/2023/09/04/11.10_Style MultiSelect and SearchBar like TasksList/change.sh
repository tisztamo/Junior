#!/bin/sh
set -e
goal="Style MultiSelect and SearchBar like TasksList"
echo "Plan:"
echo "1. Update the styles in MultiSelect.jsx to match the styles provided in TasksList.jsx."
echo "2. Update the styles in SearchBar.jsx to match the styles provided in TasksList.jsx."

# Change styles in MultiSelect.jsx
cat > src/frontend/components/MultiSelect/MultiSelect.jsx << EOF
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
    <div class="w-full bg-emphasize text-emphasize p-4 rounded border border-border">
      <ResultSet items={props.selectedItems} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
EOF

# Change styles in SearchBar.jsx
cat > src/frontend/components/MultiSelect/SearchBar.jsx << EOF
const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Enter space-separated search terms!"
      value={props.searchValue()}
      onInput={handleInputChange}
      class="border rounded p-2 w-full bg-emphasize text-emphasize"
    />
  );
};

export default SearchBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"