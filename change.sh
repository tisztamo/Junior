#!/bin/sh
# Goal: Refactor code to use getBaseUrl function
# Plan:
# 1. First, refactor the fetchTasks.js file. Import the getBaseUrl function and use it for the fetch call.
# 2. Next, refactor the generatePrompt.js file in a similar manner, changing the hard-coded URL to use the getBaseUrl function.
# 3. Then, refactor fetchDescriptor.js to use the getBaseUrl function instead of the hard-coded URL.
# 4. Finally, refactor the handleTaskChange.js file to use the getBaseUrl function instead of the hard-coded URL.

# Refactor fetchTasks.js
cat > src/frontend/fetchTasks.js << EOF
import { createSignal } from 'solid-js';
import { getBaseUrl } from './getBaseUrl';

export const fetchTasks = () => {
    const [tasks, setTasks] = createSignal([]);
    const baseUrl = getBaseUrl();
    const response = fetch(\`\${baseUrl}/tasks\`);
    response.then(r => r.json()).then(data => setTasks(data.tasks));

    return tasks;
};
EOF

# Refactor generatePrompt.js
cat > src/frontend/generatePrompt.js << EOF
import { getBaseUrl } from './getBaseUrl';

const generatePrompt = async (notes) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(\`\${baseUrl}/generate\`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes })
  });

  const data = await response.json();

  return data;
};

export { generatePrompt };
EOF

# Refactor fetchDescriptor.js
cat > src/frontend/service/fetchDescriptor.js << EOF
import { getBaseUrl } from '../getBaseUrl';

export const fetchDescriptor = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(\`\${baseUrl}/descriptor\`);
  const text = await response.text();
  return text;
};
EOF

# Refactor handleTaskChange.js
cat > src/frontend/service/handleTaskChange.js << EOF
import { getBaseUrl } from '../getBaseUrl';
import { fetchDescriptor } from './fetchDescriptor';

export const handleTaskChange = async (e, setPromptDescriptor) => {
  const baseUrl = getBaseUrl();
  const selectedTask = e.target.value;

  const response = await fetch(\`\${baseUrl}/updatetask\`, {
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
EOF
