#!/bin/sh
# Goal: Make server port configurable in the client
# Plan:
# 1. Create a new file getBaseUrl.js which fetches the base URL from the query string.
# 2. Update fetchTasks.js to use the new getBaseUrl function.

mkdir -p src/frontend

# Step 1: Create getBaseUrl.js
cat > src/frontend/getBaseUrl.js << 'EOF'
export const getBaseUrl = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const baseUrl = urlParams.get('baseUrl');

    return baseUrl || 'http://localhost:10101';
};
EOF

# Step 2: Update fetchTasks.js
cat > src/frontend/fetchTasks.js << 'EOF'
import { createSignal } from 'solid-js';
import { getBaseUrl } from './getBaseUrl';

export const fetchTasks = () => {
    const [tasks, setTasks] = createSignal([]);
    const baseUrl = getBaseUrl();
    const response = fetch(`${baseUrl}/tasks`);
    response.then(r => r.json()).then(data => setTasks(data.tasks));

    return tasks;
};
EOF
