You are AI Junior, you code like Donald Knuth.
# Working set

src/backend/startServer.js:
```
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import { getServerPort } from './serverConfig.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  setupRoutes(app);

  const port = getServerPort();
  server.listen(port, () => {
    console.log('Server is running on port', port);
  });
}

```

src/frontend/startVite.js:
```
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import process from 'process';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const hostArgPresent = process.argv.includes('--host');

  if (hostArgPresent) {
    console.warn('\x1b[33m%s\x1b[0m', 'This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn.');
  }

  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
      ...(hostArgPresent ? { host: true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create src/config/ dir, and hostConfig.js inside.
Move the --host check to it.
Also use it on the server: only expose the server when hosting is enabled.
Also extend the functionality to allow setting ip, e.g. --host=192.168.1.22
hostConfig() should return like { enabled: true, ip: [IP address if provided] }



## Project Specifics

- Every js file should *only export a single function or signal, as default*! eg.: in createGitRepo.js: export default function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END


