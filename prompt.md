# Working set

src/frontend/getBaseUrl.js:
```
export const getBaseUrl = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const baseUrl = urlParams.get('baseUrl');

    return baseUrl || 'http://localhost:10101';
};

```

src/frontend/service/createWebSocket.js:
```
export const createWebSocket = () => {
  const ws = new WebSocket('ws://localhost:3000');
  return ws;
};

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Use getBaseUrl instead of hardcoding the URL.
Derive the correct ws protocol from the base url!



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

