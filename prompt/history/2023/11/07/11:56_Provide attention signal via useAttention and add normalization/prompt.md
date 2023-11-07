You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/files/FileViewerHeader.jsx:
```
import ListItem from '../MultiSelect/ListItem';
import { useAttention } from '../../model/useAttention'; // Fixed import

const FileViewerHeader = (props) => {
  const { addAttention } = useAttention();

  // Function to handle adding to attention and closing the viewer
  const handleAddToAttentionAndClose = () => {
    addAttention(props.path);
    props.onClose();
  };

  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize pr-4" // Added right padding
        onClick={props.onClose}
        aria-label="Close"
      >
        &times;
      </button>
      <button
        class="text-3xl font-bold text-emphasize px-3" // Added horizontal padding
        onClick={handleAddToAttentionAndClose}
        aria-label="Add to Attention"
      >
        &#43; {/* Unicode for plus sign */}
      </button>
      <div class="flex-grow">
        <ListItem item={props.path} />
      </div>
    </div>
  );
};

export default FileViewerHeader;

```
./src/frontend/model/useAttention.js:
```
import { attention, setAttention } from './attentionModel';

const useAttention = () => {
  const addAttention = (path) => {
    setAttention((prev) => [...prev, path]);
  };

  return { addAttention };
};

export { useAttention };

```
./src/frontend/components/AttentionFileList.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import flattenPaths from '../service/helpers/flattenPaths';
import extractQuery from '../service/helpers/extractQuery';
import { requirements } from '../model/requirements';
import { attention, setAttention } from '../model/attentionModel';
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange } from '../service/handleAttentionChange';

const AttentionFileList = () => {
  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  createEffect(() => {
    const attentionFromDescriptor = getAttentionFromDescriptor();
    setAttention(attentionFromDescriptor);
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  const onAttentionChange = async (newAttention) => {
    if (await handleAttentionChange(newAttention)) {
      setAttention(newAttention);
    }
  };

  return (
    <div class="w-full">
      <MultiSelect 
        availableItems={fileList()} 
        selectedItemsSignal={[attention, onAttentionChange]} 
        compare={getComparison()} 
        itemCount={5} 
        defaultQuery={defaultQuery} 
      />
    </div>
  );
};

export default AttentionFileList;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Use useAttention in attentionfilelist instead of directly using the model
- When adding a file to the attention, normalize the path by removing &#34;./&#34; from its beginning. (It is a relative path)


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

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

