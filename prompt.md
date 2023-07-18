# Working set

src/backend/server.js:
```
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

```


# Task

Fix the following issue!

file:///Users/ko/projects-new/Junior/src/backend/server.js:17 const wss = new WebSocket.Server({ server });
            ^
TypeError: WebSocket.Server is not a constructor
The api is correctly called like follows:
import { WebSocketServer } from &#39;ws&#39;; ... const wss = new WebSocketServer({ server });


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

