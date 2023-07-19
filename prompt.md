# Working set

src/frontend/fetchTasks.js:
```
import { createSignal } from 'solid-js';

export const fetchTasks = () => {
    const [tasks, setTasks] = createSignal([]);

    const response = fetch('http://localhost:3000/tasks');
    response.then(r => r.json()).then(data => setTasks(data.tasks));

    return tasks;
};

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

The server port is now configurable, update the client! Default port changed to 10101. Create frontend/getBaseUrl.js! When the user adds baseUrl=http://server:port to the query string, use that.



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

