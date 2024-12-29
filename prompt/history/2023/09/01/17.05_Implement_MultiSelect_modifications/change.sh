#!/bin/sh
set -e
goal="Implement MultiSelect modifications"
echo "Plan:"
echo "1. Modify AttentionFileList.jsx according to requirements."
echo "2. Modify MultiSelect.jsx to forward the new prop."
echo "3. Modify FilteredList.jsx to utilize the new prop for item count."

# 1. Modify AttentionFileList.jsx according to requirements.
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
    <div>
      <MultiSelect availableItems={fileList()} selectedItems={[]} itemCount={5} />
    </div>
  );
};

export default AttentionFileList;
EOF

# 2. Modify MultiSelect.jsx to forward the new prop.
cat > src/frontend/components/MultiSelect.jsx << 'EOF'
import { searchValue } from '../model/searchBarModel';
import SearchBar from './SearchBar';
import ResultSet from './ResultSet';
import FilteredList from './FilteredList';

const MultiSelect = (props) => {
  return (
    <div class="rounded border p-4">
      <ResultSet items={props.selectedItems} />
      <SearchBar />
      <FilteredList items={props.availableItems} filter={searchValue()} itemCount={props.itemCount} />
    </div>
  );
};

export default MultiSelect;
EOF

# 3. Modify FilteredList.jsx to utilize the new prop for item count.
cat > src/frontend/components/FilteredList.jsx << 'EOF'
const FilteredList = (props) => {
  return (
    <ul class="list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).slice(0, props.itemCount).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"