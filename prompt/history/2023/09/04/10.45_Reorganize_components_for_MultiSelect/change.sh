#!/bin/sh
set -e
goal="Reorganize components for MultiSelect"
echo "Plan:"
echo "1. Create the components/MultiSelect directory."
echo "2. Move the MultiSelect, its subcomponents and computeFilteredList there."
echo "3. Update the imports in the moved files to maintain relative paths."

# Step 1: Create the components/MultiSelect directory
mkdir -p src/frontend/components/MultiSelect

# Step 2: Move the MultiSelect, its subcomponents and computeFilteredList there
mv src/frontend/components/MultiSelect.jsx src/frontend/components/MultiSelect/MultiSelect.jsx
mv src/frontend/components/SearchBar.jsx src/frontend/components/MultiSelect/SearchBar.jsx
mv src/frontend/components/ResultSet.jsx src/frontend/components/MultiSelect/ResultSet.jsx
mv src/frontend/components/FilteredList.jsx src/frontend/components/MultiSelect/FilteredList.jsx
mv src/frontend/components/computeFilteredList.js src/frontend/components/MultiSelect/computeFilteredList.js

# Step 3: Update the imports in the moved files to maintain relative paths

# Updating MultiSelect.jsx imports
cat > src/frontend/components/MultiSelect/MultiSelect.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';
import computeFilteredList from './computeFilteredList';

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);

  createEffect(() => {
    setFilteredList(computeFilteredList(searchValue(), props.availableItems, props.compare, props.itemCount));
  });

  return (
    <div class="w-full rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} />
      <FilteredList items={filteredList()} />
    </div>
  );
};

export default MultiSelect;
EOF

# Updating AttentionFileList.jsx for new MultiSelect path
cat > src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../services/helpers/getComparison';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  const flattenPaths = (node, path) => {
    if (node.type === 'file') {
      return [path + '/' + node.name];
    }
    if (!Array.isArray(node.children)) {
      return [];
    }
    return node.children.reduce((acc, child) => {
      return acc.concat(flattenPaths(child, path + '/' + node.name));
    }, []);
  };

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItems={[]} compare={getComparison()} itemCount={5} />
    </div>
  );
};

export default AttentionFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"