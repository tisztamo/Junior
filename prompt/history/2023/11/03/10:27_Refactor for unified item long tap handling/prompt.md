You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/MultiSelect/ResultSet.jsx:
```
import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
import handleFilePopup from './handleFilePopup';

const ResultSet = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleFilePopup();

  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} onLongTap={invoke} />)}
        </ul>
      )}
      { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default ResultSet;

```
./src/frontend/components/MultiSelect/FilteredList.jsx:
```
import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
import handleFilePopup from './handleFilePopup';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleFilePopup();

  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={invoke} />)}
      </ul>
      { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;

```
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

# Task

Refactor!

- Add a new prop named onItemLongTap to RessultSet and FilteredList
- Move the handleFilePopup call up to the MultiSelect (We need only one such handler there)
- Also move the FileViewer rendering to MultiSelect


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: Debian


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
EOF
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

