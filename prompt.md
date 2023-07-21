# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── postcss.config.js
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tailwind.config.js

```
```
./src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── execute/...
├── frontend/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── startVite.js
├── vite.config.js
├── web.js

```
```
./src/backend/
├── fileutils/...
├── getServerPort.js
├── handlers/...
├── notifyOnFileChange.js
├── serverConfig.js
├── setupRoutes.js
├── startServer.js
├── watchPromptDescriptor.js

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Create a function that resets a git repository fully, restoring everything and deleting new unstaged files, except the change of prompt.yaml
What is a good name for it?
Create a new dir in our project if you think this functionality needs its own place.



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

