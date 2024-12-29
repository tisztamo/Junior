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

  const handleResultSetItemClick = async (item, itemId) => {
    const element = document.getElementById(itemId);
    if (element) {
      element.style.transition = "opacity 0.5s, transform 0.5s";
      element.style.opacity = "0";
      element.style.transform = "translateX(-100%)";
      await new Promise(resolve => setTimeout(resolve, 500));
    }
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    setSelectedItems(updatedItems);
  };

  return (
    <div class="w-full bg-emphasize text-emphasize p-2 rounded border border-border">
      <ResultSet items={selectedItems()} onItemClick={handleResultSetItemClick} emptyMessage="Attention is empty." />
      <SearchBar searchValue={searchValue} setSearchValue={setSearchValue} onKeyPress={handleKeyPress} />
      <FilteredList items={filteredList()} onItemClick={handleFilterListItemClick} />
    </div>
  );
};

export default MultiSelect;

```


# Task

Refactor!

factor out handleResultSetItem to its own .js file


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

