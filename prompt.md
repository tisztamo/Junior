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

src/interactiveSession/saveAndSendPrompt.js:
```
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import processPrompt from '../prompt/promptProcessing.js';

const saveAndSendPrompt = async (task, last_command_result, api, rl, startInteractiveSession) => {
  let { prompt, parent_message_id } = await processPrompt(task, last_command_result);
  let lastTextLength = 0;
  console.log("\x1b[2m");
  console.debug("Query:", prompt);
  const res = await api.sendMessage(prompt, { parentMessageId: parent_message_id, onProgress: printNewText(lastTextLength) });
  parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };

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


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

The cli prompt printed for user input should be &#34;Notes:&#34; instead of $. When the user entered their notes, create and print the prompt but do not send it, ask the user to confirm the prompt. When the user confirmed the prompt, send it to the server. When not, ask the user to enter their notes again.



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

src/interactiveSession/saveAndSendPrompt.js:
```
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import processPrompt from '../prompt/promptProcessing.js';

const saveAndSendPrompt = async (task, last_command_result, api, rl, startInteractiveSession) => {
  let { prompt, parent_message_id } = await processPrompt(task, last_command_result);
  let lastTextLength = 0;
  console.log("\x1b[2m");
  console.debug("Query:", prompt);
  const res = await api.sendMessage(prompt, { parentMessageId: parent_message_id, onProgress: printNewText(lastTextLength) });
  parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };

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


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

The cli prompt printed for user input should be &#34;Notes:&#34; instead of $. When the user entered their notes, create and print the prompt but do not send it, ask the user to confirm the prompt. When the user confirmed the prompt, send it to the server. When not, ask the user to enter their notes again.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

change.sh: