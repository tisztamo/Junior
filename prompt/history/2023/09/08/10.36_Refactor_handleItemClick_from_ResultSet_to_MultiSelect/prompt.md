You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/MultiSelect/ResultSet.jsx:
```
import ListItem from "./ListItem";
import handleUnselectItem from "./handleUnselectItem";

const ResultSet = (props) => {
  const handleItemClick = (item) => {
    handleUnselectItem(item, props.setSelectedItems, props.selectedItems);
  };

  return (
    <div>
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={handleItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;

```

src/frontend/components/MultiSelect/MultiSelect.jsx:
```
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
    setFilteredList(computeFilteredList(currentQuery, props.availableItems, props.compare, props.itemCount, selectedItems(), props.defaultQuery()));
  });

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      const updatedItems = [filteredList()[0], ...selectedItems()];
      setSelectedItems(updatedItems);
    }
  };

  const handleItemClick = (item) => {
    const updatedItems = [item, ...selectedItems()];
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} emptyMessage="Attention is empty." />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleItemClick} />
    </div>
  );
};

export default MultiSelect;

```

src/frontend/components/MultiSelect/ListItem.jsx:
```
import { createEffect } from "solid-js";

const ListItem = (props) => {
  let pathRef;

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item);
    }
  };

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div onClick={handleClick} class={`flex justify-between items-center w-full font-mono cursor-pointer transition-fast item-${props.item}`}>
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;

```

src/frontend/components/MultiSelect/handleUnselectItem.jsx:
```
import { createEffect } from 'solid-js';

const handleUnselectItem = (item, setSelectedItems, selectedItems) => {
  createEffect(() => {
    // Fade-out effect
    const element = document.querySelector(`.item-${item}`);
    if (element) {
      element.classList.add('opacity-0');
      setTimeout(() => {
        const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
        setSelectedItems(updatedItems);
      }, 300); // 300ms is the default duration for Tailwind's fast transition
    }
  });
};

export default handleUnselectItem;

```


# Task

Refactor!

Move handleItemClick from ResultSet to MultiSelect. Rename the one already there to handleFilterListItemCLick and this one to handleResultSetItemClick


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

