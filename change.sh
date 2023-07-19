#!/bin/sh
# Goal: Use createWebSocket to decide the url
# Plan:
# 1. Update useWebsocket.js to use createWebSocket for WebSocket creation.
# 2. Update TasksList.jsx to pass the onMessage callback to useWebsocket without the url.

cat << 'EOF' > src/frontend/service/useWebsocket.js
import { createEffect } from 'solid-js';
import { createWebSocket } from './createWebSocket.js';

export const useWebsocket = (onMessage) => {
  let socket = createWebSocket();

  socket.onopen = () => console.log('WebSocket is connected');
  socket.onmessage = onMessage;
  socket.onerror = (error) => console.log('WebSocket error:', error);

  createEffect(() => {
    if (!socket || socket.readyState === WebSocket.CLOSED) {
      socket = createWebSocket();
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

cat << 'EOF' > src/frontend/components/TasksList.jsx
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

  useWebsocket(async (e) => {
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
