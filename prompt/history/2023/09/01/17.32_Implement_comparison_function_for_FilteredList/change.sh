#!/bin/sh
set -e
goal="Implement comparison function for FilteredList"
echo "Plan:"
echo "1. Create a new directory for service/helpers."
echo "2. Create a file inside service/helpers that exports a function to generate comparison functions."
echo "3. Modify MultiSelect.jsx to accept a comparison function and pass it to FilteredList."
echo "4. Modify FilteredList.jsx to use the comparison function if provided and break the long line."
echo "5. Modify AttentionFileList.jsx to utilize the new comparison function."

# Step 1: Create new directory
mkdir -p src/frontend/services/helpers

# Step 2: Create a function inside services/helpers
cat > src/frontend/services/helpers/getComparison.js << 'EOF'
const getComparison = () => {
  return (item, filter) => item.includes(filter);
};

export default getComparison;
EOF

# Step 3: Modify MultiSelect.jsx
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
      <FilteredList 
        items={props.availableItems} 
        filter={searchValue()} 
        compare={props.compare} 
        itemCount={props.itemCount} 
      />
    </div>
  );
};

export default MultiSelect;
EOF

# Step 4: Modify FilteredList.jsx
cat > src/frontend/components/FilteredList.jsx << 'EOF'
const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter));
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items
        .filter(item => comparisonFunction(item, props.filter))
        .slice(0, props.itemCount)
        .map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
EOF

# Step 5: Modify AttentionFileList.jsx
cat > src/frontend/components/AttentionFileList.jsx << 'EOF'
import { createEffect } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect';
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