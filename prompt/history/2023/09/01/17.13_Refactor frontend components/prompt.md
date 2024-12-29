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
    <div class="rounded border p-4">
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
    <div>
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
    <ul class="list-disc pl-5">
      {props.items.filter(item => item.includes(props.filter)).slice(0, props.itemCount).map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;

```


# Task

Refactor the mentioned files!

Look for
  - unused imports
  - unneeded comments
  - ugly names
  - misplaced files
  - code repetition
  - code smell

When a file is bigger than 40 lines, split it: Identify the possible parts and create separate files!

- Remove the extra div in multiselect.
- Make all the components w-full.


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

