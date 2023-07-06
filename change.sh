#!/bin/bash

# Update TasksList.jsx
cat > ./src/frontend/components/TasksList.jsx << 'EOF'
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  
  const handleTaskChange = async (e) => {
    const selectedTask = e.target.value;

    const response = await fetch('http://localhost:3000/updatetask', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ task: selectedTask })
    });

    if (response.ok) {
      // Fetch the updated descriptor
      const response = await fetch('http://localhost:3000/descriptor');
      const text = await response.text();
      setPromptDescriptor(text);
    }
  };

  onMount(async () => {
    const response = await fetch('http://localhost:3000/descriptor');
    const text = await response.text();
    setPromptDescriptor(text);
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div>
      <label>Tasks:</label>
      <select onChange={handleTaskChange}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default TasksList;
EOF
#!/bin/bash

# Create new handler file for update task endpoint
cat > ./src/backend/updateTaskHandler.js << 'EOF'
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
    document.task = task;

    const newYamlStr = yaml.dump(document);
    await writeFile(filePath, newYamlStr, 'utf-8');
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
EOF

# Update handlers.js to import updateTaskHandler
cat > ./src/backend/handlers.js << 'EOF'
import processPrompt from '../prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';
import { updateTaskHandler } from './updateTaskHandler.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};

export const descriptorHandler = servePromptDescriptor;
export const taskUpdateHandler = updateTaskHandler;
EOF

# Update server.js to add new endpoint
cat > ./src/backend/server.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';

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
EOF
