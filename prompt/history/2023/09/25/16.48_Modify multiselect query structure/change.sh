#!/bin/sh
set -e
goal="Modify multiselect query structure"
echo "Plan:"
echo "1. Modify extractQuery to return an array of objects with keywords (lowercased) and weights."
echo "2. Adjust getComparison to process the new array structure."
echo "3. Update MultiSelect component to use modified extractQuery on search value only if it's not the default query."

cat > ./src/frontend/service/helpers/extractQuery.js << 'EOF'
const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
  return requirements.split(/\W+/)
    .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
    .map(word => ({ keyword: word.toLowerCase(), weight: 1.0 }));
}
EOF

cat > ./src/frontend/service/helpers/getComparison.js << 'EOF'
const getComparison = () => {
  return (item, filter) => {
    const lowercasedItem = item.toLowerCase();
    // Calculate the rank based on the sum of the lengths of matching words multiplied by their weights.
    const rank = filter.reduce((acc, { keyword, weight }) => {
      return lowercasedItem.includes(keyword) ? acc + (keyword.length * weight) : acc;
    }, 0);
    return rank;
  };
};

export default getComparison;
EOF

cat > ./src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import MultiSelectHeader from './MultiSelectHeader';
import computeFilteredList from './computeFilteredList';
import handleResultSetItemClick from './handleResultSetItemClick';
import extractQuery from '../../service/helpers/extractQuery';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);
  const selectedItemsSignal = props.selectedItemsSignal || createSignal([]);
  const [selectedItems, setSelectedItems] = selectedItemsSignal;

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