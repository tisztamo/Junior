#!/bin/sh
set -e
goal="Refactor handleResultSetItem out"
echo "Plan:"
echo "1. Create handleResultSetItem.js file and move handleResultSetItemClick function to it."
echo "2. Update MultiSelect.jsx to import handleResultSetItemClick from new file."

# Step 1: Create handleResultSetItem.js file
cat > src/frontend/components/MultiSelect/handleResultSetItem.js << 'EOF'
const handleResultSetItemClick = async (item, itemId, selectedItems) => {
    const element = document.getElementById(itemId);
    if (element) {
        element.style.transition = "opacity 0.5s, transform 0.5s";
        element.style.opacity = "0";
        element.style.transform = "translateX(-100%)";
        await new Promise(resolve => setTimeout(resolve, 500));
    }
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    return updatedItems;
};

export default handleResultSetItemClick;
EOF

# Step 2: Update MultiSelect.jsx to import the refactored function
cat > src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';
import handleResultSetItemClick from './handleResultSetItem';

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

  const onResultSetItemClick = async (item, itemId) => {
    const updatedItems = await handleResultSetItemClick(item, itemId, selectedItems);
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} onItemClick={onResultSetItemClick} emptyMessage="Attention is empty." />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleFilterListItemClick} />
    </div>
  );
};

export default MultiSelect;
EOF

echo "\033[32mDone: $goal\033[0m\n"