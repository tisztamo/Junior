You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
```
src/
├── attention/...
├── backend/...
├── config.js
├── execute/...
├── frontend/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── utils/...
├── vite.config.js

```
src/frontend/components/PromptDescriptorViewer.jsx:
```
import { createSignal, onMount } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';

const PromptDescriptorViewer = () => {
  const [descriptorContent, setDescriptorContent] = createSignal('');

  onMount(async () => {
    const text = await fetchDescriptor();
    setDescriptorContent(text);
  });

  return (
    <pre>{descriptorContent()}</pre>
  );
};

export default PromptDescriptorViewer;

```

src/frontend/components/TasksList.jsx:
```
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import YAML from 'yaml';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  const [selectedTask, setSelectedTask] = createSignal('');

  const parseYamlAndGetTask = (yamlString) => {
    const doc = YAML.parse(yamlString);
    return doc.task;
  };

  onMount(async () => {
    const text = await fetchDescriptor();
    const task = parseYamlAndGetTask(text);
    setPromptDescriptor(text);
    setSelectedTask(task);
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div>
      <label>Task:</label>
      <select value={selectedTask()} onChange={e => handleTaskChange(e, setPromptDescriptor)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default TasksList;

```

src/frontend/service/fetchDescriptor.js:
```
export const fetchDescriptor = async () => {
  const response = await fetch('http://localhost:3000/descriptor');
  const text = await response.text();
  return text;
};

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

- After page open the task selector should show the task that is currently
  selected. It can be read out from the prompt descriptor, which is a yaml with a task attrobute.
- And the label should be &#34;Task:&#34;.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

