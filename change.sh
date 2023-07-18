#!/bin/sh
# Goal: Update prompt descriptor on file change
# Plan:
# 1. Implement a WebSocket on the backend to notify the frontend of file changes.
# 2. Use the "watchPromptDescriptor.js" module to send a message through this WebSocket when the descriptor file changes.
# 3. On the frontend, set up a WebSocket connection and listen for messages about file changes.
# 4. When a message is received, make a request to fetch the new descriptor and update the state in the "TasksList.jsx" component.

cat <<EOF >src/backend/notifyOnFileChange.js
import WebSocket from 'ws';
import { watchPromptDescriptor } from '../prompt/watchPromptDescriptor.js';

export const notifyOnFileChange = (wss) => {
  watchPromptDescriptor(() => {
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send('update');
      }
    });
  });
};
EOF

cat <<EOF >src/backend/server.js
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import WebSocket from 'ws';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';

export function startServer() {
  console.log(process.cwd())
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocket.Server({ server });

  notifyOnFileChange(wss);

  app.get('/descriptor', descriptorHandler);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', taskUpdateHandler);

  server.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}
EOF

cat <<EOF >src/frontend/service/useWebsocket.js
import { createEffect } from 'solid-js';

export const useWebsocket = (url, onMessage) => {
  let socket = new WebSocket(url);

  socket.onopen = () => console.log('WebSocket is connected');
  socket.onmessage = onMessage;
  socket.onerror = (error) => console.log('WebSocket error:', error);

  createEffect(() => {
    if (!socket || socket.readyState === WebSocket.CLOSED) {
      socket = new WebSocket(url);
      socket.onmessage = onMessage;
    }
  });

  return () => {
    if (socket && socket.readyState === WebSocket.OPEN) {
      socket.close();
    }
  };
};
EOF

cat <<EOF >src/frontend/components/TasksList.jsx
import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';
import { useWebsocket } from '../service/useWebsocket';

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

  useWebsocket('ws://localhost:3000', async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
    }
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
EOF
