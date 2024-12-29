You are AI Junior, you code like Donald Knuth.

# Working set

src/backend/fileutils/getIgnoreList.js:
```
function getIgnoreList() {
  const DEFAULT_IGNORE = [
    '.git',
    'node_modules',
    './prompt',
    'dist',
    'build',
    'tmp',
    'temp',
    '.vscode',
    '.idea',
    'coverage',
    '.env',
    '.DS_Store',
    'logs',
    'package-lock.json',
    'yarn.lock',
    '*.pyc',
    '__pycache__',
    '.venv',
    'venv',
    'target',
    '*.class',
    '*.exe',
    '*.test',
    'vendor/',
    '*.gem',
    '.bundle',
    'Gemfile.lock',
    'Cargo.lock',
    'bin/',
    'obj/',
    '*.suo',
    '*.user',
    '*.xcodeproj',
    '*.xcworkspace',
    'Pods/',
    'pubspec.lock',
    '.dart_tool/',
    'out/',
    '*.tsbuildinfo',
    '*.Rproj.user',
    '*.Rhistory',
    '*.pl~',
    'cpanfile.snapshot',
    'project/',
    'dist/',
    '*.hi',
    '_build/',
    'deps/',
    '*.log',
    '*.asv'
  ];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  const totalIgnore = [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];

  const nameIgnore = totalIgnore.filter(item => !item.startsWith('./'));
  const pathIgnore = totalIgnore.filter(item => item.startsWith('./')).map(item => item.slice(2));

  return { nameIgnore, pathIgnore };
}

export default getIgnoreList;

```
src/backend/getServerPort.js:
```
function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_SERVER_PORT || 10101;
}

export default getServerPort;

```
src/backend/handlers/configHandler.js:
```
async function configHandler(req, res) {
  // Extract CLI arguments, skipping the first two elements (node path & script name)
  const cliArgs = process.argv.slice(2);
  res.json({ cliArgs });
}

export { configHandler };

```
src/backend/serverConfig.js:
```
import process from 'process';

export function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return Number(portArg.split('=')[1]);
  }
  
  if (process.env.JUNIOR_SERVER_PORT) {
    return Number(process.env.JUNIOR_SERVER_PORT);
  }
  
  return 10101;
}

```
src/backend/terminal/setupTerminalServer.js:
```
import os from 'os';
import pty from 'node-pty';

export default function setupTerminalServer(socket) {
  const defaultShell = process.env.SHELL || '/bin/sh';
  const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
  const terminal = pty.spawn(shell, [], {
    name: 'xterm-color',
    env: process.env,
  });

  socket.on('message', (data) => {
    const parsedData = JSON.parse(data);

    if (parsedData.type === 'resize') {
      terminal.resize(parsedData.cols, parsedData.rows);
    } else if (parsedData.type === 'input') {
      terminal.write(parsedData.data);
    }
  });

  terminal.on('data', (data) => {
    socket.send(data);
  });

  terminal.on('exit', () => {
    socket.close();
  });
}

```
src/config/hostConfig.js:
```
import process from 'process';

export default function hostConfig() {
  const hostArg = process.argv.find(arg => arg.startsWith('--host'));

  if (!hostArg) {
    return { enabled: false };
  }

  if (hostArg === '--host') {
    return { enabled: true };
  }

  const ip = hostArg.split('=')[1];
  return { enabled: true, ip };
}

```
src/config.js:
```
import readline from 'readline';
import createApi from './llm/openai/createApi.js';
import createFakeApi from './llm/fake/createFakeApi.js';

function isDryRun() {
  return process.argv.includes("-d") || process.argv.includes("--dry-run");
}

function get_model() {
  const modelArg = process.argv.find(arg => arg.startsWith('--model='));
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

async function getApi() {
  if (isDryRun()) {
    return createFakeApi();
  } else {
    return await createApi(get_model());
  }
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

export { getApi, rl, get_model };

```
src/execute/AuditTrailConfig.js:
```
let warned = false;

export default function AuditTrailConfig() {
    const enabled = !process.argv.includes('--noaudit');
    if (!enabled && !warned) {
        console.warn('Warning: Audit trail is disabled.');
        warned = true;
    }
    return { enabled };
}

```
src/frontend/getFrontendPort.js:
```
function getFrontendPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--frontend-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_FRONTEND_PORT || 5864;
}

export default getFrontendPort;

```
src/llm/openai/createApi.js:
```
import fs from 'fs';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "../../prompt/getSystemPrompt.js";
import createFakeApi from '../fake/createFakeApi.js';

export default async function createApi(model) {
  let apiKey = process.env.OPENAI_API_KEY;

  if (!apiKey) {
    if (fs.existsSync('./secret.sh')) {
      const secretFileContent = fs.readFileSync('./secret.sh', 'utf-8');
      const match = secretFileContent.match(/export OPENAI_API_KEY=(\S+)/);
      if (match) {
        apiKey = match[1];
      }
    }
  }

  if (!apiKey) {
    console.warn('OPENAI_API_KEY not found, using fake API');
    return createFakeApi();
  }

  const systemMessage = await getSystemPrompt();

  return new ChatGPTAPI({
    debug: true,
    apiKey,
    systemMessage,
    completionParams: {
      model,
      stream: true,
      temperature: 0.5,
      max_tokens: 2048,
    }
  });
}

```
src/prompt/getSystemPromptIfNeeded.js:
```
import { getSystemPrompt } from "./getSystemPrompt.js";

async function getSystemPromptIfNeeded(force = false) {
  if (force || process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

export { getSystemPromptIfNeeded };

```
src/prompt/getPromptFlag.js:
```
function getPromptFlag() {
  const promptFlag = process.argv.find(arg => arg.startsWith("--prompt="));
  if (promptFlag) {
    return promptFlag.split("=")[1];
  }
}

export { getPromptFlag };

```

# Task

Improve the documentation!

Generate docs/config/env_or_cli.md which documents all the possible configurations.
Structure it like follows:
- intro, similar to a man page in its content
- list of configurations (merge env/argv configs where they do the same)
- examples (include one for hosting on a vpn ip, and one ignoring a dir from attention scan.

The Junior process is started with npx junior-web [args], npx junior-cli [args], or, in the case you start it from the git repo for self-development: npm start -- [args]

Do NOT create backup files.

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


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

