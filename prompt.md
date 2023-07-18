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
src/main.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';
import { getSystemPrompt } from './prompt/getSystemPrompt.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await getSystemPrompt())

startInteractiveSession(rl, api);

export { startInteractiveSession };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Do not print the system prompt at startup



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

