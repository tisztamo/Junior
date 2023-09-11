#!/bin/sh
set -e
goal="Refactor handleItemClick from ResultSet to MultiSelect"
echo "Plan:"
echo "1. Remove handleItemClick from ResultSet"
echo "2. Update ListItem usage in ResultSet"
echo "3. Rename handleItemClick in MultiSelect to handleFilterListItemClick"
echo "4. Add handleResultSetItemClick in MultiSelect"
echo "5. Update imports"

# Step 1: Remove handleItemClick from ResultSet
cat <<EOF > src/frontend/components/MultiSelect/ResultSet.jsx
import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <div>
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;
EOF

# Step 2: Update ListItem usage in ResultSet
# No change required, since we just passed the prop in ResultSet

# Step 3: Rename handleItemClick in MultiSelect to handleFilterListItemClick
# Step 4: Add handleResultSetItemClick in MultiSelect
cat <<EOF > src/frontend/components/MultiSelect/MultiSelect.jsx
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';
import handleUnselectItem from "./handleUnselectItem";

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

  const handleFilterListItemClick = (item) => {
    const updatedItems = [item, ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  const handleResultSetItemClick = (item) => {
    handleUnselectItem(item, setSelectedItems, selectedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} onItemClick={handleResultSetItemClick} emptyMessage="Attention is empty." />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleFilterListItemClick} />
    </div>
  );
};

export default MultiSelect;
EOF

# Step 5: Update imports
# Already included in the MultiSelect refactoring

echo "\033[32mDone: $goal\033[0m\n"