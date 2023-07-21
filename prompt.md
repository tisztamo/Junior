# Working set

```
src/backend/
├── fileutils/...
├── getServerPort.js
├── handlers/...
├── listTasks.js
├── notifyOnFileChange.js
├── servePromptDescriptor.js
├── serverConfig.js
├── setupRoutes.js
├── startServer.js
├── updateTaskHandler.js
├── watchPromptDescriptor.js

```
src/backend/setupRoutes.js:
```
import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';
import { updateTaskHandler } from './updateTaskHandler.js';
import { listTasks } from './listTasks.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
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

src/backend/updateTaskHandler.js:
```
import { readFile, writeFile } from 'fs/promises';
import path from 'path';
import yaml from 'js-yaml';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const updateTaskHandler = async (req, res) => {
  const task = req.body.task;
  const filePath = path.resolve(__dirname, '../../prompt.yaml');

  try {
    const fileContent = await readFile(filePath, 'utf-8');
    const document = yaml.load(fileContent);

    // assuming 'task' is a field in the yaml document
    document.task = path.join("prompt", "task", task);

    const newYamlStr = yaml.dump(document);
    await writeFile(filePath, newYamlStr, 'utf-8');
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

```

src/backend/listTasks.js:
```
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

import { readDirRecursively } from './fileutils/readDirRecursively.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const listTasks = () => {
    const tasksDir = path.join(__dirname, '../../prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};

```


# Task

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Move the files except setupRoutes to the handlers dir!


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

