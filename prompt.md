You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

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

Fix the following issue!

Print an orange warning to the console when hostArgPresent is true:
This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn
(Reword if needed for easy understanding)



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

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

