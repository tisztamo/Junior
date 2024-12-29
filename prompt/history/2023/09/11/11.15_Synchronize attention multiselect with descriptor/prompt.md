You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/AttentionFileList.jsx:
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

  return (
    <div class="w-full">
      <MultiSelect availableItems={fileList()} selectedItemsSignal={[attention, setAttention]} compare={getComparison()} itemCount={5} defaultQuery={defaultQuery} />
    </div>
  );
};

export default AttentionFileList;

```

src/backend/routes/setupPromptRoutes.js:
```
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
}

```

src/frontend/service/handleTaskChange.js:
```
import { getBaseUrl } from '../getBaseUrl';
import { fetchDescriptor } from './fetchDescriptor';
import { setPromptDescriptor } from '../model/promptDescriptor';

export const handleTaskChange = async (e) => {
  const baseUrl = getBaseUrl();
  const selectedTask = e.target.value;

  const response = await fetch(`${baseUrl}/updatetask`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ task: selectedTask })
  });

  if (response.ok) {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  }
};

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

High level context: The attention multiselect result set should be synchronized with the prompt descriptor attention field
Current task:
  - Create handleAttentionChange.js, which can post to /descriptor as { attention }
  - When the user changes the attention, use it.
  - handleTaskChange is for reference


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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

