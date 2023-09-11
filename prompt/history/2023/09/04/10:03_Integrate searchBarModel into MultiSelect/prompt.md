You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/MultiSelect.jsx:
```
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

```

src/frontend/components/SearchBar.jsx:
```
import { searchValue, setSearchValue } from '../model/searchBarModel';

const SearchBar = () => {
  const handleInputChange = (e) => {
    setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Enter space-separated search terms!"
      value={searchValue()}
      onInput={handleInputChange}
      class="border rounded p-2 w-full"
    />
  );
};

export default SearchBar;

```

src/frontend/components/ResultSet.jsx:
```
const ResultSet = (props) => {
  return (
    <ul class="list-disc pl-5">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;

```

src/frontend/components/FilteredList.jsx:
```
const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items
        // Filter by non-zero ranks.
        .filter(item => comparisonFunction(item, props.filter) > 0)
        // Sort items by rank, highest rank first.
        .sort((a, b) => comparisonFunction(b, props.filter) - comparisonFunction(a, props.filter))
        .slice(0, props.itemCount)
        .map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;

```

src/frontend/model/searchBarModel.js:
```
import { createSignal } from 'solid-js';

const [searchValue, setSearchValue] = createSignal('');

export { searchValue, setSearchValue };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Move the serachbar model to multiselect, deleting the separate file.



## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


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

