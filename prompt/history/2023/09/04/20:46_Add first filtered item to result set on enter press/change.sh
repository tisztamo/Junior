#!/bin/sh
set -e
goal="Add first filtered item to result set on enter press"
echo "Plan:"
echo "1. Modify MultiSelect.jsx to create a signal for selectedItems and a method to add to it."
echo "2. Update the SearchBar component to detect the Enter keypress and trigger the addition of the first filtered item."
echo "3. Pass necessary props and signals from MultiSelect to SearchBar."

# Modify MultiSelect.jsx to add selectedItems signal and update method.
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
    setFilteredList(computeFilteredList(searchValue(), props.availableItems, props.compare, props.itemCount));
  });

  const addFirstFilteredItem = () => {  // Add the first item from the filtered list to selected items
    const updatedItems = [filteredList()[0], ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-4 rounded border border-border">
      <ResultSet items={selectedItems()} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} addFirstFilteredItem={addFirstFilteredItem} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
EOF

# Update SearchBar to detect Enter key press and add the first filtered item.
cat > src/frontend/components/MultiSelect/SearchBar.jsx << 'EOF'
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
      onKeyPress={handleKeyPress}  // Detect key press
      class="border rounded p-2 w-full bg-emphasize text-emphasize"
    />
  );
};

export default SearchBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"