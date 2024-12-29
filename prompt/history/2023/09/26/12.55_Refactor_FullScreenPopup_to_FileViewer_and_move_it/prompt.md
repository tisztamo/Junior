You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/MultiSelect/FullScreenPopup.jsx:
```
import SourceFileDisplay from '../files/SourceFileDisplay';

const FullScreenPopup = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto">
          <div class="absolute top-4 right-4" onClick={props.onClose}></div>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FullScreenPopup;

```
./src/frontend/components/MultiSelect/ResultSet.jsx:
```
import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import handleLongTap from './handleLongTap';

const ResultSet = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} onLongTap={invoke} />)}
        </ul>
      )}
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default ResultSet;

```
./src/frontend/components/MultiSelect/FilteredList.jsx:
```
import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import handleLongTap from './handleLongTap';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={invoke} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;

```

# Task

Refactor!

Rename FullScreenPopup to FileViewer (both filename and component), and move it to components/files



## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

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

