You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/MultiSelect/FilteredList.jsx:
```
import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import { createSignal } from 'solid-js';

const FilteredList = (props) => {
  const [showPopup, setShowPopup] = createSignal(false);
  const [popupPath, setPopupPath] = createSignal('');

  const handleLongTap = (path) => {
    setPopupPath(path);
    setShowPopup(true);
  };

  return (
    <div>
      <ul class="list-inside">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={handleLongTap} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;

```

./src/frontend/components/MultiSelect/ResultSet.jsx:
```
import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <div>
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Long tap activates  default functionality (text selection) of the browser,  which should be prevented. For this add select-none class to the filtered list and the result set


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
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


