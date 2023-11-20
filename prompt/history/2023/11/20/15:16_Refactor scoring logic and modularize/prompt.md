You are AI Junior, you code like Donald Knuth.

# Working set

src/frontend/service/helpers/scoringConstants.js:
```
export const scoringConstants = {
    START_SCORE: 1.0,
    DECREMENT: 0.125,
    MIN_SCORE: 0.25
};

export function getDecreasingScore(index) {
    const { START_SCORE, DECREMENT, MIN_SCORE } = scoringConstants;
    let score = START_SCORE - (index * DECREMENT);
    return score < MIN_SCORE ? MIN_SCORE : score;
}

```
src/frontend/components/MultiSelect/computeFilteredList.js:
```
import computeRank from './computeRank';

export default function computeFilteredList(searchValue, items, compare, itemCount, selectedItems = [], defaultQuery = "") {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return items
    .filter(item => !selectedItems.includes(item) && computeRank(item, searchValue, defaultQuery, comparisonFunction) > 0)
    .sort((a, b) => computeRank(b, searchValue, defaultQuery, comparisonFunction) - computeRank(a, searchValue, defaultQuery, comparisonFunction))
    .slice(0, itemCount);
}

```
src/frontend/components/MultiSelect/computeRank.js:
```
const computeRank = (item, searchValue, defaultQuery, comparisonFunction) => {
  const searchValueRank = comparisonFunction(item, searchValue);
  const defaultQueryRank = comparisonFunction(item, defaultQuery);
  return searchValueRank + defaultQueryRank;
};

export default computeRank;

```
src/frontend/service/helpers/extractQuery.js:
```
import { getDecreasingScore } from './scoringConstants';

const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
    return requirements.split(/\W+/)
        .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
        .map((word, index) => ({ keyword: word.toLowerCase(), weight: getDecreasingScore(index) }));
}

```

# Task

Refactor!

- Factor out the getDecreasingScore function to its own file with the same name.
- Fix the working of getDecreasingScore so that it goes down exponentially in (1 - DECREMENT) steps.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[FULL content of the file]
EOF
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

