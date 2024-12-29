You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/MultiSelect/FilteredListItem.jsx:
```
import { createEffect } from "solid-js";

const FilteredListItem = (props) => {
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
    <div onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default FilteredListItem;

```

src/frontend/components/MultiSelect/ResultSet.jsx:
```
const ResultSet = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default ResultSet;

```

src/frontend/components/MultiSelect/FilteredList.jsx:
```
import FilteredListItem from "./FilteredListItem";

const FilteredList = (props) => {
  return (
    <ul class="list-inside">
      {props.items.map((item, idx) => <FilteredListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} />)}
    </ul>
  );
};

export default FilteredList;

```


# Task

Move the following files to the specified target dirs!

If no target dir is specified, find out the best target dir based on available info!

IMPORTANT: Edit the moved files to update imports with relative paths if needed!

You need to follow dependencies to maintain coherence. Update imports!

1. Rename FilteredlListItem to ListItem (also the file)
2. Use ListItem when rendering the result set.



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

