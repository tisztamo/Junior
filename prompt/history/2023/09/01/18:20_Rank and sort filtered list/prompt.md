You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/services/helpers/getComparison.js:
```
const getComparison = () => {
  return (item, filter) => {
    // GOAL OF THE CHANGE: Split the filter into words
    const filterWords = filter.split(/\s+/).map(word => word.toLowerCase());

    // GOAL OF THE CHANGE: Convert the item to lowercase for case-insensitive comparison
    const lowercasedItem = item.toLowerCase();

    // GOAL OF THE CHANGE: Check if any word from the filter is included in the item
    return filterWords.some(word => lowercasedItem.includes(word));
  };
};

export default getComparison;

```

src/frontend/components/FilteredList.jsx:
```
const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter));
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items
        .filter(item => comparisonFunction(item, props.filter))
        .slice(0, props.itemCount)
        .map(item => <li key={item}>{item}</li>)}
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

The comparison function should return the rank: The sum of the lengths of the matching words.
The filtered list should look for non-zero ranks and sort the items before rendering, highest rank first.



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

