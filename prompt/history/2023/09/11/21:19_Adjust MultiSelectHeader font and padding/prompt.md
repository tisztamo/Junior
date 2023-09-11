You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/MultiSelect/MultiSelectHeader.jsx:
```
const MultiSelectHeader = (props) => {
  const handleClearClick = async (event) => {
    event.preventDefault(); // This prevents the details tag from being switched
    props.onClear();
  };

  const attentionFileCountMessage = (fileCount) => {
    if (fileCount === 1) {
      return '1 file in attention';
    }
    return `${fileCount} files in attention`;
  };

  return (
    <summary>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1 }}>
          { props.items().length > 0 ? attentionFileCountMessage(props.items().length) : props.emptyMessage }
        </div>
        { props.items().length > 0 && 
          <a href="#" class="cursor-pointer ml-2 text-blue-500" onClick={handleClearClick}>
            clear
          </a>
        }
      </div>
    </summary>
  );
};

export default MultiSelectHeader;

```

./src/frontend/components/TasksList.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../model/selectedTask';
import { promptDescriptor } from '../model/promptDescriptor';
import { getYamlEntry } from '../service/getYamlEntry';

const TasksList = () => {
  const tasks = fetchTasks();

  createEffect(() => {
    const descriptor = promptDescriptor();
    if (descriptor !== '') {
      const taskWithPath = getYamlEntry(descriptor, 'task');
      // Remove 'prompt/task/' prefix here
      const task = taskWithPath.replace('prompt/task/', '');
      setSelectedTask(task);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border">
      <label class="text-lg mr-2">Task:</label>
      <select class="w-full bg-emphasize text-emphasize text-lg" value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Multiselect header should use the same font as the task selector and have some padding both left to the message and left to the summary element


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


