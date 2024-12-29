#!/bin/sh
set -e
goal="Integrate searchBarModel into MultiSelect"
echo "Plan:"
echo "1. Move the searchValue and setSearchValue signals to the MultiSelect.jsx file."
echo "2. Update the SearchBar component to receive the searchValue and setSearchValue as props."
echo "3. Update the FilteredList component in the MultiSelect to utilize the updated searchValue."
echo "4. Delete the searchBarModel.js file as its functionality is moved to the MultiSelect component."

# Move the searchValue and setSearchValue signals to the MultiSelect.jsx file
cat > src/frontend/components/MultiSelect.jsx <<EOF
import { createSignal } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal(''); // Moved the searchBarModel logic to this component

  return (
    <div class="w-full rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} />
      <FilteredList 
        items={props.availableItems} 
        filter={searchValue()} 
        compare={props.compare} 
        itemCount={props.itemCount} 
      />
    </div>
  );
};

export default MultiSelect;
EOF

# Update the SearchBar component to receive the searchValue and setSearchValue as props
cat > src/frontend/components/SearchBar.jsx <<EOF
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
      class="border rounded p-2 w-full"
    />
  );
};

export default SearchBar;
EOF

# FilteredList and ResultSet remain the same, no changes.

# Deleting the searchBarModel.js file as its functionality is now inside the MultiSelect component
rm src/frontend/model/searchBarModel.js

echo "\033[32mDone: $goal\033[0m\n"