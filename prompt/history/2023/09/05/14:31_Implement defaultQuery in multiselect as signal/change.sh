#!/bin/sh
set -e
goal="Implement defaultQuery in multiselect as signal"
echo "Plan:"
echo "1. Modify MultiSelect to accept defaultQuery prop."
echo "2. Change defaultQuery in AttentionFileList to a signal."
echo "3. Update MultiSelect's filteredList effect to consider defaultQuery."
echo "4. Update AttentionFileList to pass defaultQuery signal to MultiSelect."

# Step 1: Modify MultiSelect to accept defaultQuery prop.
cat > src/frontend/components/MultiSelect/MultiSelect.jsx <<EOF
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
    setFilteredList(computeFilteredList(currentQuery, props.availableItems, props.compare, props.itemCount, selectedItems()));
  });

  const addFirstFilteredItem = () => {
    const updatedItems = [filteredList()[0], ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} addFirstFilteredItem={addFirstFilteredItem} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
EOF

# Step 2: Change defaultQuery in AttentionFileList to a signal.
cat > src/frontend/components/AttentionFileList.jsx <<EOF
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';
import extractQuery from '../service/helpers/extractQuery';
import { requirements } from '../model/requirements';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItems={[]} compare={getComparison()} itemCount={5} defaultQuery={defaultQuery} />
    </div>
  );
};

export default AttentionFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"