# Working set

src/prompt/watchPromptDescriptor.js:
```
import fs from 'fs';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { descriptorFileName } from './promptDescriptorConfig.js';

const watchPromptDescriptor = (rawPrinter) => {
  fs.watchFile(descriptorFileName, async (curr, prev) => {
    if (curr.mtime !== prev.mtime) {
      await loadPromptDescriptor(rawPrinter);
    }
  });
};

export default watchPromptDescriptor;

```

src/backend/notifyOnFileChange.js:
```
import WebSocket from 'ws';
import { watchPromptDescriptor } from '../prompt/watchPromptDescriptor.js';

export const notifyOnFileChange = (wss) => {
  watchPromptDescriptor(() => {
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send('update');
      }
    });
  });
};

```


# Task

Fix the following issue!

file:///Users/ko/projects-new/Junior/src/backend/notifyOnFileChange.js:2 import { watchPromptDescriptor } from &#39;../prompt/watchPromptDescriptor.js&#39;;
         ^^^^^^^^^^^^^^^^^^^^^
SyntaxError: The requested module &#39;../prompt/watchPromptDescriptor.js&#39; does not provide an export named &#39;watchPromptDescriptor&#39;


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

