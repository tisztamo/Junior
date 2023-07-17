# Working set

```
./
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...

```
package.json:
```
{
  "name": "@aijunior/dev",
  "version": "0.0.1",
  "description": "Your AI Contributor",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "src/main.js",
    "junior-web": "npm start"
  },
  "scripts": {
    "cli": "node src/main.js",
    "start": "node src/web.js"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
  "dependencies": {
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "clipboard-copy": "^4.0.1",
    "cors": "^2.8.5",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "js-yaml": "^4.1.0",
    "marked": "^5.1.0",
    "postcss": "^8.4.24",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.2",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0"
  },
  "directories": {
    "doc": "doc"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  },
  "bugs": {
    "url": "https://github.com/tisztamo/Junior/issues"
  },
  "homepage": "https://github.com/tisztamo/Junior#readme",
  "devDependencies": {
    "babel-preset-solid": "^1.7.7"
  }
}

```

src/main.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';
import { getSystemPrompt } from './prompt/getSystemPrompt.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await getSystemPrompt())

startInteractiveSession("", null, rl, api);

export { startInteractiveSession };

```

src/web.js:
```
import { startServer } from './startServer.js';
import { startVite } from './startVite.js';

startServer();
startVite();

```

src/startServer.js:
```
import { startServer as startBackendServer } from './backend/server.js';

export function startServer() {
  startBackendServer();
}

```

src/backend/server.js:
```
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';

export function startServer() {
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
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

&#34;npx junior-web&#34; from dependent projects should work, starting web.js.



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

