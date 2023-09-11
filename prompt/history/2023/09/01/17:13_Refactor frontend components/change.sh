#!/bin/sh
set -e
goal="Refactor frontend components"
echo "Plan:"
echo "1. Remove unused imports from AttentionFileList.jsx."
echo "2. Modify MultiSelect.jsx to remove extra div and make it w-full."
echo "3. Update FilteredList.jsx to make it w-full."
echo "4. Update AttentionFileList.jsx to make it w-full."

# 1. Removing unused imports from AttentionFileList.jsx
cat > src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect';

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
      <MultiSelect availableItems={fileList()} selectedItems={[]} itemCount={5} />
    </div>
  );
};

export default AttentionFileList;
EOF

# 2. Modify MultiSelect.jsx to remove extra div and make it w-full
cat > src/frontend/components/MultiSelect.jsx << 'EOF'
import { searchValue } from '../model/searchBarModel';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';

const MultiSelect = (props) => {
  return (
    <div class="w-full rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar />
      <FilteredList items={props.availableItems} filter={searchValue()} itemCount={props.itemCount} />
    </div>
  );
};

export default MultiSelect;
EOF

# 3. Update FilteredList.jsx to make it w-full
cat > src/frontend/components/FilteredList.jsx << 'EOF'
const FilteredList = (props) => {
  return (
    <ul class="w-full list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).slice(0, props.itemCount).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"