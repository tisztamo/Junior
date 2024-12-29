#!/bin/sh
set -e
goal="Eliminate transition and handle unselect in MultiSelect"
echo "Plan:"
echo "1. Delete handleUnselectItem.jsx."
echo "2. Modify MultiSelect.jsx to handle unselection directly."
echo "3. Modify ListItem.jsx to include the auto-scroll right for the path and remove transition-related logic."

# Step 1: Delete handleUnselectItem.jsx
rm src/frontend/components/MultiSelect/handleUnselectItem.jsx

# Step 2: Modify MultiSelect.jsx to handle unselection directly
cat <<'EOF' > src/frontend/components/MultiSelect/MultiSelect.jsx
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
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    setSelectedItems(updatedItems);
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

# Step 3: Modify ListItem.jsx to include the auto-scroll right for the path and remove transition-related logic
cat <<'EOF' > src/frontend/components/MultiSelect/ListItem.jsx
import { createEffect } from "solid-js";

const ListItem = (props) => {
  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item);
    }
  };

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div onClick={handleClick} class={`flex justify-between items-center w-full font-mono cursor-pointer item-${props.item}`}>
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"