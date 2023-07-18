# Working set

src/backend/server.js:
```
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';

export function startServer() {
  console.log(process.cwd())
  const app = express();

  app.use(cors());
  app.use(express.json());

  app.get('/descriptor', descriptorHandler);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', taskUpdateHandler);

  app.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}

```

src/backend/servePromptDescriptor.js:
```
import { readFile } from 'fs/promises';
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const servePromptDescriptor = async (req, res) => {
  const file = await readFile(path.resolve(__dirname, '../../prompt.yaml'), 'utf-8');
  res.send(file);
};

```

src/prompt/watchPromptDescriptor.js:
```
import fs from 'fs';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { descriptorFileName } from './promptDescriptorConfig.js';

const watchPromptDescriptor = (rawPrinter) => {
  fs.watchFile(descriptorFileName, async (curr, prev) => {
    if (curr.mtime !== prev.mtime) {
      await loadPromptDescriptor(rawPrinter);
    }
  });
};

export default watchPromptDescriptor;

```

src/frontend/components/TasksList.jsx:
```
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  const [selectedTask, setSelectedTask] = createSignal('');

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

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

During the web session, whenever the prompt descriptor file changes, update it on the screen!



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

