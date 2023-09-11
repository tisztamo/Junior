#!/bin/sh
set -e
goal="Add trashcan icon & clear selection using Unicode"
echo "Plan:"
echo "1. Modify MultiSelectHeader.jsx to wrap content inside a flex `div` to ensure visibility of the details arrow."
echo "2. Update the CSS to allow the content to grow within the `div`."
echo "3. Add an onClick handler to the trashcan icon to clear the selected items."
echo "4. Ensure all modified files only export a single function or signal."

# Modify MultiSelectHeader to conditionally show Unicode trashcan icon with the message
# and also wrap the content inside a div that uses flex layout.
cat > src/frontend/components/MultiSelect/MultiSelectHeader.jsx << 'EOF'
const MultiSelectHeader = (props) => {
  return (
    <summary>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1 }}>
          { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
        </div>
        { props.items().length > 0 && 
          <span class="cursor-pointer ml-2" onClick={props.onClear}>
            🗑
          </span>
        }
      </div>
    </summary>
  );
};

export default MultiSelectHeader;
EOF

# Modify MultiSelect to provide onClear callback
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

  const handleClearSelection = () => {
    setSelectedItems([]);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <details open>
        <MultiSelectHeader items={selectedItems} emptyMessage="Attention is empty." onClear={handleClearSelection} />
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
