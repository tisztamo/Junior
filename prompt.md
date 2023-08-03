# Working set

```
src/frontend/
├── App.jsx
├── assets/...
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.html
├── index.jsx
├── postcss.config.cjs
├── service/...
├── startVite.js
├── stores/...
├── styles/...
├── tailwind.config.cjs
├── vite.config.js

```
```
src/frontend/stores/
├── change.js
├── commitMessage.js
├── executionResult.js
├── gitStatus.js
├── monitorChange.js
├── prompt.js
├── promptDescriptor.js
├── selectedTask.js

```

# Task

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Rename src/frontend/stores to src/frontend/model


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

