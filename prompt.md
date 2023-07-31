# Working set

src/frontend/startVite.js:
```
import { exec } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export function startVite() {
  const vite = exec(`${projectRoot}/node_modules/.bin/vite ${projectRoot}/src/frontend --open`);
  vite.stdout.pipe(process.stdout);
  vite.stderr.pipe(process.stderr);

  process.on('exit', () => vite.kill());
}

```


# Task

Improve the documentation!

Rewrite startVite to use the js api! Here is a sample from the vite docs for your help:
import { fileURLToPath } from &#39;url&#39; import { createServer } from &#39;vite&#39;
const __dirname = fileURLToPath(new URL(&#39;.&#39;, import.meta.url))
;(async () =&gt; {
  const server = await createServer({
    root: __dirname,
    server: {
      port: 1337,
    },
  })
  await server.listen()

  server.printUrls()
})()

default port is ok, but be sure to open the browser and start from the dir found in the current version of startVite.js


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

