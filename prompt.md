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
src/frontend/App.jsx:
```
import { createSignal } from 'solid-js';
import PromptDescriptorViewer from './PromptDescriptorViewer';
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  return (
    <>
      <PromptDescriptorViewer />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;

```

src/frontend/PromptDescriptorViewer.jsx:
```
import { createSignal, onMount } from 'solid-js';

const PromptDescriptorViewer = () => {
  const [descriptorContent, setDescriptorContent] = createSignal('');

  onMount(async () => {
    const response = await fetch('http://localhost:3000/descriptor');
    const text = await response.text();
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
import { fetchTasks } from '../fetchTasks';

const TasksList = () => {
  const tasks = fetchTasks();

  return (
    <div>
      <label>Tasks:</label>
      <select>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;

```

src/backend/server.js:
```
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler } from './handlers.js';
import { listTasks } from './listTasks.js';

const app = express();

app.use(cors());
app.use(express.json());

app.get('/descriptor', descriptorHandler);
app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

app.post('/generate', generateHandler);

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

```

src/backend/handlers.js:
```
import processPrompt from '../prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};

export const descriptorHandler = servePromptDescriptor;

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


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

When selecting a task, - Stage 1: POST the selected value to http://localhost:3000/updatetask
  When done, reload the prompt descriptor on the frontend.
- Stage 2: An endpoint on the server
  which updates the prompt descriptor (prompt.yaml),

Implement Stage 1!



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

