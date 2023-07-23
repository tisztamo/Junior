# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
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
./doc/
├── .nojekyll
├── api/...
├── buildDoc.js
├── convertDirectory.js
├── createMarkdownRenderer.js
├── example.html
├── example.md
├── examples/...
├── getting-started/...
├── index.html
├── introduction.html
├── introduction.md

```
```
./src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── execute/...
├── frontend/...
├── git/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── startVite.js
├── vite.config.js
├── web.js

```
doc/buildDoc.js:
```
import createMarkdownRenderer from './createMarkdownRenderer';
import convertDirectory from './convertDirectory';

const md = createMarkdownRenderer();
convertDirectory('./doc', md);

```

doc/convertDirectory.js:
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

doc/createMarkdownRenderer.js:
```
import MarkdownIt from 'markdown-it';
import hljs from 'highlight.js';

export default function createMarkdownRenderer() {
    return new MarkdownIt({
        html: true,
        linkify: true,
        typographer: true,
        highlight: function (str, lang) {
            if (lang && hljs.getLanguage(lang)) {
                try {
                    return hljs.highlight(str, { language: lang }).value;
                } catch (__) {}
            }
            return ''; 
        }
    });
}

```


# Task

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Move every .js file from doc to src/doc
update the line
&#34;build:docs&#34;: &#34;node ./doc/build.js&#34; 
in package.json accordingly


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

