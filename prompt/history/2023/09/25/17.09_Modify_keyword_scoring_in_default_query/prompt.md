You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/MultiSelect/MultiSelect.jsx:
```
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

```
./src/frontend/components/MultiSelect/computeFilteredList.js:
```
import computeRank from './computeRank';

export default function computeFilteredList(searchValue, items, compare, itemCount, selectedItems = [], defaultQuery = "") {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return items
    .filter(item => !selectedItems.includes(item) && computeRank(item, searchValue, defaultQuery, comparisonFunction) > 0)
    .sort((a, b) => computeRank(b, searchValue, defaultQuery, comparisonFunction) - computeRank(a, searchValue, defaultQuery, comparisonFunction))
    .slice(0, itemCount);
}

```
./src/frontend/components/AttentionFileList.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';
import extractQuery from '../service/helpers/extractQuery';
import { requirements } from '../model/requirements';
import { attention, setAttention } from '../model/attentionModel';
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange } from '../service/handleAttentionChange';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  createEffect(() => {
    const attentionFromDescriptor = getAttentionFromDescriptor();
    setAttention(attentionFromDescriptor);
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  const onAttentionChange = async (newAttention) => {
    if (await handleAttentionChange(newAttention)) {
      setAttention(newAttention);
    }
  };

  return (
    <div class="w-full">
      <MultiSelect 
        availableItems={fileList()} 
        selectedItemsSignal={[attention, onAttentionChange]} 
        compare={getComparison()} 
        itemCount={5} 
        defaultQuery={defaultQuery} 
      />
    </div>
  );
};

export default AttentionFileList;

```
./src/frontend/service/helpers/extractQuery.js:
```
const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
  return requirements.split(/\W+/)
    .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
    .map(word => ({ keyword: word.toLowerCase(), weight: 1.0 }));
}

```
./src/frontend/service/helpers/getComparison.js:
```
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

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Words of the default query should be scored as follows:
- The first one is 1.0
- Next is 12.5% lower
- And so on
- But stop going down at 0.25
Put the constants to an object and return the object from a function in a separated file.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

