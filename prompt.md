# Working set

src/config.js:
```
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "./prompt/getSystemPrompt.js";

function isDryRun() {
  return process.argv.includes("-d") || process.argv.includes("--dry-run");
}

const api = isDryRun() ? {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  } : new ChatGPTAPI({
  debug: true,
  apiKey: process.env.OPENAI_API_KEY,
  systemMessage: await getSystemPrompt(),
  completionParams: {
    model: get_model(),
    stream: true,
    temperature: 0.5,
    max_tokens: 2048,
  }
});

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function get_model() {
  const modelArg = process.argv.find(arg => arg.startsWith('--model='));
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

export { api, rl, get_model };

```

src/backend/server.js:
```
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';

export function startServer() {
  console.log(process.cwd())
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  setupRoutes(app);

  server.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}

```

src/startServer.js:
```
import { startServer as startBackendServer } from './backend/server.js';

export function startServer() {
  startBackendServer();
}

```

src/web.js:
```
#!/usr/bin/env node
import { startServer } from './startServer.js';
import { startVite } from './startVite.js';

startServer();
startVite();

```

src/backend/setupRoutes.js:
```
import { generateHandler } from './generateHandler.js';
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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Move the server to port 10101, and allow configuration through the JUNIOR_SERVER_PORT environment variable or the --server-port=10101 command line argument. Create a new file in backend for handling this config, and reexport the functionality from config.js
Also refactor by moving the logic from backend/server.js to backend/startServer.js, and using src/backend/startServer.js from web.js instead of the current, outer one. Delete server.js and src/startServer.js



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

