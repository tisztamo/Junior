You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/MultiSelect/FilteredListItem.jsx:
```
import { createEffect } from "solid-js";

const FilteredListItem = (props) => {
  let itemRef;

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item);
    }
  };

  createEffect(() => {
    if (itemRef) {
      itemRef.scrollLeft = itemRef.scrollWidth;
    }
  });

  return (
    <div onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span ref={itemRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden mr-4 py-2">{props.item}</span>
      <span class="border-l border-border pl-2 pr-2">{props.idx}</span>
    </div>
  );
};

export default FilteredListItem;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

In multiselect list item:
- Numbers should be shown on the left. Also adjust the separating border accordingly.
- Item text should be displayed in two separate parts: Assume it is a path, the filename should be on the left with larger font, followed by the directory path.


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

