#!/bin/sh
set -e
goal="Refactor for unified item long tap handling"
echo "Plan:"
echo "1. Modify ResultSet.jsx to accept onItemLongTap prop."
echo "2. Modify FilteredList.jsx to accept onItemLongTap prop."
echo "3. Move handleFilePopup and FileViewer from ResultSet and FilteredList to MultiSelect.jsx."
echo "4. Update MultiSelect.jsx accordingly."

# Modify ResultSet.jsx
cat > ./src/frontend/components/MultiSelect/ResultSet.jsx << 'EOF'
import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} onLongTap={props.onItemLongTap} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;
EOF
echo "1. Modified ResultSet.jsx"

# Modify FilteredList.jsx
cat > ./src/frontend/components/MultiSelect/FilteredList.jsx << 'EOF'
import ListItem from "./ListItem";

const FilteredList = (props) => {
  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={props.onItemLongTap} />)}
      </ul>
    </div>
  );
};

export default FilteredList;
EOF
echo "2. Modified FilteredList.jsx"

# Update MultiSelect.jsx
cat > ./src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import MultiSelectHeader from './MultiSelectHeader';
import FileViewer from '../files/FileViewer';
import computeFilteredList from './computeFilteredList';
import handleResultSetItemClick from './handleResultSetItemClick';
import extractQuery from '../../service/helpers/extractQuery';
import handleFilePopup from './handleFilePopup';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);
  const selectedItemsSignal = props.selectedItemsSignal || createSignal([]);
  const [selectedItems, setSelectedItems] = selectedItemsSignal;
  const { showPopup, popupPath, invoke, setShowPopup } = handleFilePopup();

  createEffect(() => {
    const currentQuery = searchValue() === props.defaultQuery() ? props.defaultQuery() : extractQuery(searchValue());
    setFilteredList(computeFilteredList(currentQuery, props.availableItems, props.compare, props.itemCount, selectedItems(), props.defaultQuery()));
  });

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      const updatedItems = [...selectedItems(), filteredList()[0]];
      setSelectedItems(updatedItems);
    }
  };

  const handleFilterListItemClick = (item) => {
    const updatedItems = [...selectedItems(), item];
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
          <ResultSet items={selectedItems()} onItemClick={onResultSetItemClick} onItemLongTap={invoke} />
          <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
          <FilteredList items={filteredList()} onItemClick={handleFilterListItemClick} onItemLongTap={invoke} />
          { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
        </div>
      </details>
    </div>
  );
};

export default MultiSelect;
EOF
echo "3. Updated MultiSelect.jsx"
echo "\033[32mDone: $goal\033[0m\n"