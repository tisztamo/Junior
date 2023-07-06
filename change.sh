#!/bin/bash

cat > ./src/backend/listTasks.js << EOF
import fs from 'fs';
import path from 'path';

function readDirRecursively(dir) {
    const files = [];

    fs.readdirSync(dir).forEach(file => {
        const filePath = path.join(dir, file);

        if (fs.statSync(filePath).isDirectory()) {
            files.push(...readDirRecursively(filePath));
        } else {
            files.push(filePath);
        }
    });

    return files;
}

export const listTasks = () => {
    const tasksDir = path.join(__dirname, '../../prompt/task');
    return readDirRecursively(tasksDir).map(file => path.relative(tasksDir, file));
};
EOF

cat > ./src/backend/server.js << EOF
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
EOF

cat > ./src/frontend/fetchTasks.js << EOF
import { createSignal } from 'solid-js';

export const fetchTasks = async () => {
    const [tasks, setTasks] = createSignal([]);

    const response = await fetch('/tasks');
    const data = await response.json();
    
    setTasks(data.tasks);

    return tasks;
};
EOF

cat > ./src/frontend/App.jsx << EOF
import { createSignal } from 'solid-js';
import { marked } from 'marked';
import copy from 'clipboard-copy';
import { generatePrompt } from './generatePrompt';
import { fetchTasks } from './fetchTasks';
import PromptDescriptorViewer from './PromptDescriptorViewer';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');
  const tasks = fetchTasks();

  const handleGeneratePrompt = async () => {
    const response = await generatePrompt(notes());

    copy(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <>
      <PromptDescriptorViewer />
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={handleGeneratePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
      <div>
        <label>Tasks:</label>
        <select>
          {tasks().map(task => <option value={task}>{task}</option>)}
        </select>
      </div>
    </>
  );
};

export default App;
EOF
