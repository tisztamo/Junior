#!/bin/sh
set -e
goal="Implement unique id and slide-fade feature"
echo "Plan:"
echo "1. Modify ListItem to generate a unique id instead of class item-\${props.item}."
echo "2. Pass the id to the click handler as the second argument in ListItem."
echo "3. Modify the MultiSelect component to implement the slide-fade effect based on the id before unselecting."
echo "4. Create necessary CSS for slide-fade effect."

# Step 1: Modify ListItem
cat > src/frontend/components/MultiSelect/ListItem.jsx << 'EOF'
import { createEffect } from "solid-js";

const ListItem = (props) => {
  let pathRef;
  const uniqueId = `item-${Math.random().toString(36).substr(2, 9)}`;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item, uniqueId);
    }
  };

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div id={uniqueId} onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;
EOF

# Step 2: This is handled within the above step by passing uniqueId to the click handler.

# Step 3: Modify MultiSelect
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

  const handleResultSetItemClick = async (item, itemId) => {
    const element = document.getElementById(itemId);
    if (element) {
      element.style.transition = "opacity 0.5s, transform 0.5s";
      element.style.opacity = "0";
      element.style.transform = "translateX(-100%)";
      await new Promise(resolve => setTimeout(resolve, 500));
    }
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

# Step 4: Create necessary CSS for slide-fade effect is handled within the MultiSelect.jsx file by adding inline styles.

echo "\033[32mDone: $goal\033[0m\n"