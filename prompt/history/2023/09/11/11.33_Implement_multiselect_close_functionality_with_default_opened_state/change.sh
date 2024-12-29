#!/bin/sh
set -e
goal="Implement multiselect close functionality with default opened state"
echo "Plan:"
echo "1. Modify MultiSelectHeader.jsx to remove the bg-lightgray and act as the summary for the details tag."
echo "2. Change MultiSelect.jsx to wrap the content inside <details> and <summary> tags, and ensure the default state is open."

# Edit MultiSelectHeader to act as a summary and remove the bg-lightgray
cat > src/frontend/components/MultiSelect/MultiSelectHeader.jsx << 'EOF'
const MultiSelectHeader = (props) => {
  return (
    <summary class="w-full p-2">
      { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
    </summary>
  );
};

export default MultiSelectHeader;
EOF

# Edit MultiSelect to wrap the content inside details and summary tags with default open state
cat > src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
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
      <details open>
        <MultiSelectHeader items={selectedItems} emptyMessage="Attention is empty." />
        <div>
          <ResultSet items={selectedItems()} onItemClick={onResultSetItemClick} />
          <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
          <FilteredList items={filteredList()} onItemClick={handleFilterListItemClick} />
        </div>
      </details>
    </div>
  );
};

export default MultiSelect;
EOF

echo "\033[32mDone: $goal\033[0m\n"