# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
src/interactiveSession/startInteractiveSession.js:
```
import processPrompt from '../prompt/promptProcessing.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, parent_message_id: newParentMessageId } = await processPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, newParentMessageId, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };

```

src/interactiveSession/handleApiResponse.js:
```
import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg, last_command_result, parent_message_id, rl, api) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod, last_command_result, parent_message_id, rl, api);
  } else {
    last_command_result = "";
    startInteractiveSession(last_command_result, parent_message_id, rl, api);
  }
}

export { handleApiResponse };

```

src/execute/extractCode.js:
```

function extractCode(res) {
  const match = res.match(/```sh([\s\S]*?)```/);
  return match ? match[1].trim() : null;
}

export default extractCode;

```

src/execute/executeCode.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";
import { exec } from 'child_process';

const executeCode = async (cod, last_command_result, parent_message_id, rl) => {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', async (answer) => {
    console.log("");
    if (answer.toLowerCase() === 'y' || answer === "") {
      exec(cod, (error, stdout, stderr) => {
        if (error) {
          console.error(`${error.message}`);
          last_command_result = "Command failed. Output:\n" + error.message + "\n";
        } else {
          if (stdout.length > 0) {
            console.log(`${stdout}`);
          }
          if (stderr.length > 0) {
            console.log(`${stderr}`);
          }
          last_command_result = "Command executed. Output:\n" + stdout + "\n" + stderr + "\n";
        }
        startInteractiveSession(last_command_result, parent_message_id, rl)
      });
    } else {
      last_command_result = "Command skipped.\n";
      startInteractiveSession(last_command_result, parent_message_id, rl);
    }
  });
}

export { executeCode };

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

scripts from bash code blocks should also be extracted and executed.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
src/interactiveSession/startInteractiveSession.js:
```
import processPrompt from '../prompt/promptProcessing.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, parent_message_id: newParentMessageId } = await processPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, newParentMessageId, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };

```

src/interactiveSession/handleApiResponse.js:
```
import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg, last_command_result, parent_message_id, rl, api) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod, last_command_result, parent_message_id, rl, api);
  } else {
    last_command_result = "";
    startInteractiveSession(last_command_result, parent_message_id, rl, api);
  }
}

export { handleApiResponse };

```

src/execute/extractCode.js:
```

function extractCode(res) {
  const match = res.match(/```sh([\s\S]*?)```/);
  return match ? match[1].trim() : null;
}

export default extractCode;

```

src/execute/executeCode.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";
import { exec } from 'child_process';

const executeCode = async (cod, last_command_result, parent_message_id, rl) => {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', async (answer) => {
    console.log("");
    if (answer.toLowerCase() === 'y' || answer === "") {
      exec(cod, (error, stdout, stderr) => {
        if (error) {
          console.error(`${error.message}`);
          last_command_result = "Command failed. Output:\n" + error.message + "\n";
        } else {
          if (stdout.length > 0) {
            console.log(`${stdout}`);
          }
          if (stderr.length > 0) {
            console.log(`${stderr}`);
          }
          last_command_result = "Command executed. Output:\n" + stdout + "\n" + stderr + "\n";
        }
        startInteractiveSession(last_command_result, parent_message_id, rl)
      });
    } else {
      last_command_result = "Command skipped.\n";
      startInteractiveSession(last_command_result, parent_message_id, rl);
    }
  });
}

export { executeCode };

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

scripts from bash code blocks should also be extracted and executed.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

