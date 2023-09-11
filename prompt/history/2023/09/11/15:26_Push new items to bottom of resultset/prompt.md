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

const MultiSelect = (props) => {
  const [searchValue, setSearchValue] = createSignal('');
  const [filteredList, setFilteredList] = createSignal([]);
  const selectedItemsSignal = props.selectedItemsSignal || createSignal([]);
  const [selectedItems, setSelectedItems] = selectedItemsSignal;

  createEffect(() => {
    const currentQuery = searchValue() || props.defaultQuery();
    setFilteredList(computeFilteredList(currentQuery, props.availableItems, props.compare, props.itemCount, selectedItems(), props.defaultQuery()));
  });

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      const updatedItems = [filteredList()[0], ...selectedItems()];
      setSelectedItems(updatedItems);
    }
  };

  const handleFilterListItemClick = (item) => {
    const updatedItems = [item, ...selectedItems()];
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

./src/frontend/components/MultiSelect/handleResultSetItemClick.js:
```
const handleResultSetItemClick = async (item, itemId, selectedItems) => {
    const element = document.getElementById(itemId);
    if (element) {
        element.style.transition = "opacity 0.3s, transform 0.3s";
        element.style.opacity = "0";
        element.style.transform = "scaleY(0)";
        await new Promise(resolve => setTimeout(resolve, 300));
    }
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    return updatedItems;
};

export default handleResultSetItemClick;

```

./src/frontend/components/MultiSelect/ResultSet.jsx:
```
import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <div>
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Push new items to the bottom of resultset


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

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


