You are AI Junior, you code like Donald Knuth.
# Working set

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
    setFilteredList(computeFilteredList(currentQuery, props.availableItems, props.compare, props.itemCount, selectedItems()));
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
      <ResultSet items={selectedItems()} />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleItemClick} />
    </div>
  );
};

export default MultiSelect;

```

src/frontend/components/MultiSelect/SearchBar.jsx:
```
const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Suggestions below. Search here!"
      value={props.searchValue()}
      onInput={handleInputChange}
      onKeyPress={props.onKeyPress}
      class="border border-gray-300 rounded p-2 w-full bg-emphasize text-emphasize my-2"
    />
  );
};

export default SearchBar;

```

src/frontend/components/MultiSelect/computeFilteredList.js:
```
export default function computeFilteredList(searchValue, items, compare, itemCount, selectedItems = []) {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  return items
    .filter(item => !selectedItems.includes(item) && comparisonFunction(item, searchValue) > 0)
    .sort((a, b) => comparisonFunction(b, searchValue) - comparisonFunction(a, searchValue))
    .slice(0, itemCount);
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Calculate the rank for the default query and add it to the searchvalue based rank when sorting.


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

