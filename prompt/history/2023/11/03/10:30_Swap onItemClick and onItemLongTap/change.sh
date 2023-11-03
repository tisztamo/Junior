#!/bin/sh
set -e
goal="Swap onItemClick and onItemLongTap"
echo "Plan:"
echo "1. Modify the MultiSelect component to swap the onItemClick and onItemLongTap functions."
echo "2. Ensure the changes follow the ES6 and SolidJS standards."

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
          <ResultSet items={selectedItems()} onItemClick={invoke} onItemLongTap={onResultSetItemClick} />
          <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
          <FilteredList items={filteredList()} onItemClick={invoke} onItemLongTap={handleFilterListItemClick} />
          { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
        </div>
      </details>
    </div>
  );
};

export default MultiSelect;

EOF
echo "\033[32mDone: $goal\033[0m\n"