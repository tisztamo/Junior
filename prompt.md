# Working set

src/doc/buildDoc.js:
```
import convertDirectory from './convertDirectory';
import createMarkdownRenderer from './createMarkdownRenderer';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);

```

src/doc/convertDirectory.js:
```
import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname } from 'path';
import createMarkdownRenderer from './createMarkdownRenderer';

export default function convertDirectory(dir, md = createMarkdownRenderer()) {
    const files = readdirSync(dir);
    files.forEach(file => {
        const filePath = join(dir, file);
        const stats = statSync(filePath);
        if (stats.isDirectory()) {
            convertDirectory(filePath, md);
        } else if (extname(file) === '.md') {
            const markdown = readFileSync(filePath, 'utf8');
            const html = md.render(markdown);
            writeFileSync(filePath.replace('.md', '.html'), html);
        }
    });
}

```


# Task

Fix the following issue!

Fix relative imports by adding .js to the end of the path.


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

