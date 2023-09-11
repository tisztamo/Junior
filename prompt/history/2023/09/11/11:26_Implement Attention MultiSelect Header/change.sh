#!/bin/sh
set -e
goal="Implement Attention MultiSelect Header"
echo "Plan:"
echo "1. Create MultiSelectHeader.jsx to handle the display of the number of selected items and empty message."
echo "2. Update MultiSelect.jsx to use the new MultiSelectHeader component."

# 1. Create MultiSelectHeader.jsx
cat > ./src/frontend/components/MultiSelect/MultiSelectHeader.jsx << 'EOF'
const MultiSelectHeader = (props) => {
  return (
    <div class="w-full p-2 bg-lightgray">
      { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
    </div>
  );
};

export default MultiSelectHeader;
EOF

# 2. Update MultiSelect.jsx to use MultiSelectHeader
cat > ./src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import MultiSelectHeader from './MultiSelectHeader';
import computeFilteredList from './computeFilteredList';
import handleResultSetItemClick from './handleResultSetItemClick';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);
  const selectedItemsSignal = props.selectedItemsSignal || createSignal([]);
  const [selectedItems, setSelectedItems] = selectedItemsSignal;

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
      <MultiSelectHeader items={selectedItems} emptyMessage="Attention is empty." />
      <ResultSet items={selectedItems()} onItemClick={onResultSetItemClick} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleFilterListItemClick} />
    </div>
  );
};

export default MultiSelect;
EOF

echo "\033[32mDone: $goal\033[0m\n"