You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/AttentionFileList.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { fileList, setFileList } from '../model/fileList';
import fetchFileList from '../service/fetchFileList';
import MultiSelect from './MultiSelect/MultiSelect';
import getComparison from '../service/helpers/getComparison';
import { requirements } from '../model/requirements';
import { useAttention } from '../model/useAttention'; // Importing the updated useAttention hook
import { getAttentionFromDescriptor } from '../service/getAttentionFromDescriptor';
import { handleAttentionChange as handleAttentionChangeService } from '../service/handleAttentionChange';

const AttentionFileList = () => {
  const { addAttention, attention } = useAttention(); // Using the updated useAttention hook

  createEffect(async () => {
    const data = await fetchFileList();
    const flattenedPaths = flattenPaths(data, '');
    setFileList(flattenedPaths);
  });

  createEffect(() => {
    const attentionFromDescriptor = getAttentionFromDescriptor();
    attentionFromDescriptor.forEach(path => addAttention(path)); // Using addAttention from the updated hook
  });

  const [defaultQuery, setDefaultQuery] = createSignal("");

  createEffect(() => {
    setDefaultQuery(extractQuery(requirements()));
  });

  const onAttentionChange = async (newAttention) => {
    if (await handleAttentionChangeService(newAttention)) {
      newAttention.forEach(path => addAttention(path)); // Using addAttention from the updated hook
    }
  };

  return (
    <div class="w-full">
      <MultiSelect 
        availableItems={fileList()} 
        selectedItemsSignal={[attention, onAttentionChange]} // Using the attention signal from the updated hook
        compare={getComparison()} 
        itemCount={5} 
        defaultQuery={defaultQuery} 
      />
    </div>
  );
};

export default AttentionFileList;

```
./src/frontend/service/helpers/extractQuery.js:
```
import { getDecreasingScore } from './scoringConstants';

const ignoreList = ['and', 'or', 'the'];

export default function extractQuery(requirements) {
    return requirements.split(/\W+/)
        .filter(word => word.length > 2 && !ignoreList.includes(word.toLowerCase()))
        .map((word, index) => ({ keyword: word.toLowerCase(), weight: getDecreasingScore(index) }));
}

```
./src/frontend/service/helpers/flattenPaths.js:
```
const flattenPaths = (node, path = '') => {
  if (node.type === 'file') {
    return [path ? `${path}/${node.name}` : node.name];
  }
  if (!Array.isArray(node.children)) {
    return [];
  }
  return node.children.reduce((acc, child) => {
    return acc.concat(flattenPaths(child, path ? `${path}/${node.name}` : node.name));
  }, []);
};

export default flattenPaths;

```

# Task

Fix the following issue!

Uncaught ReferenceError: extractQuery is not defined
    at Object.fn (AttentionFileList.jsx:36:5)
    at runComputation (chunk-ZA7VKWKE.js?v=484326ba:798:22)
    at updateComputation (chunk-ZA7VKWKE.js?v=484326ba:777:3)
    at runTop (chunk-ZA7VKWKE.js?v=484326ba:901:7)
    at runUserEffects (chunk-ZA7VKWKE.js?v=484326ba:1031:5)
    at chunk-ZA7VKWKE.js?v=484326ba:982:22
    at runUpdates (chunk-ZA7VKWKE.js?v=484326ba:922:17)
    at completeUpdates (chunk-ZA7VKWKE.js?v=484326ba:982:5)
    at runUpdates (chunk-ZA7VKWKE.js?v=484326ba:923:5)
    at createRoot (chunk-ZA7VKWKE.js?v=484326ba:187:12)
(anonymous) @ AttentionFileList.jsx:36
runComputation @ chunk-ZA7VKWKE.js?v=484326ba:798
updateComputation @ chunk-ZA7VKWKE.js?v=484326ba:777
runTop @ chunk-ZA7VKWKE.js?v=484326ba:901
runUserEffects @ chunk-ZA7VKWKE.js?v=484326ba:1031
(anonymous) @ chunk-ZA7VKWKE.js?v=484326ba:982
runUpdates @ chunk-ZA7VKWKE.js?v=484326ba:922
completeUpdates @ chunk-ZA7VKWKE.js?v=484326ba:982
runUpdates @ chunk-ZA7VKWKE.js?v=484326ba:923
createRoot @ chunk-ZA7VKWKE.js?v=484326ba:187
render @ chunk-DXTYZR5Z.js?v=484326ba:539
(anonymous) @ index.jsx:4
useWebsocket.js:7 WebSocket is connected
AttentionFileList.jsx:26 Uncaught (in promise) ReferenceError: flattenPaths is not defined
    at Object.fn (AttentionFileList.jsx:26:28)
(anonymous) @ AttentionFileList.jsx:26
await in (anonymous) (async)
runComputation @ chunk-ZA7VKWKE.js?v=484326ba:798
updateComputation @ chunk-ZA7VKWKE.js?v=484326ba:777
runTop @ chunk-ZA7VKWKE.js?v=484326ba:901
runUserEffects @ chunk-ZA7VKWKE.js?v=484326ba:1031
(anonymous) @ chunk-ZA7VKWKE.js?v=484326ba:982
runUpdates @ chunk-ZA7VKWKE.js?v=484326ba:922
completeUpdates @ chunk-ZA7VKWKE.js?v=484326ba:982
runUpdates @ chunk-ZA7VKWKE.js?v=484326ba:923
createRoot @ chunk-ZA7VKWKE.js?v=484326ba:187
render @ chunk-DXTYZR5Z.js?v=484326ba:539
(anonymous) @ index.jsx:4


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

