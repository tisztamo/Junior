#!/bin/sh
set -e
goal="Implement fade and shrink animation"
echo "Plan:"
echo "1. Rename handleResultSetItem.js to handleResultSetItemClick.js"
echo "2. Modify handleResultSetItemClick.js to fade and shrink vertically instead of translating"
echo "3. Update MultiSelect.jsx to import from the renamed file"

# Step 1: Rename handleResultSetItem.js to handleResultSetItemClick.js
mv src/frontend/components/MultiSelect/handleResultSetItem.js src/frontend/components/MultiSelect/handleResultSetItemClick.js

# Step 2: Modify handleResultSetItemClick.js to fade and shrink vertically instead of translating
cat > src/frontend/components/MultiSelect/handleResultSetItemClick.js << 'EOF'
const handleResultSetItemClick = async (item, itemId, selectedItems) => {
    const element = document.getElementById(itemId);
    if (element) {
        element.style.transition = "opacity 0.3s, transform 0.3s";
        element.style.opacity = "0";
        element.style.transform = "scaleY(0)";
        await new Promise(resolve => setTimeout(resolve, 300));
    }
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    return updatedItems;
};

export default handleResultSetItemClick;
EOF

# Step 3: Update MultiSelect.jsx to import from the renamed file
# Heredoc-ing the full file using 'EOF'
cat > src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';
import handleResultSetItemClick from './handleResultSetItemClick';

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