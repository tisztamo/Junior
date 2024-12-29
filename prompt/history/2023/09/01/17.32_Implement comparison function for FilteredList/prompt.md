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
      <FilteredList items={props.availableItems} filter={searchValue()} itemCount={props.itemCount} />
    </div>
  );
};

export default MultiSelect;

```

src/frontend/components/AttentionFileList.jsx:
```
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

```

src/frontend/components/FilteredList.jsx:
```
const FilteredList = (props) => {
  return (
    <ul class="w-full list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).slice(0, props.itemCount).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

If the filtered list gets a function, treat it as a comparison function.
Create a new function in services/helpers/ (Create the dir)
that returns another which is then used to match.
Don't forget to update MultiSelect



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

