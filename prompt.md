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
./doc: err!

./doc/build.js:
```
import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname } from 'path';
import MarkdownIt from 'markdown-it';
import hljs from 'highlight.js';

const md = new MarkdownIt({
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

const convertDirectory = (dir) => {
  const files = readdirSync(dir);
  files.forEach(file => {
    const filePath = join(dir, file);
    const stats = statSync(filePath);
    if (stats.isDirectory()) {
      convertDirectory(filePath);
    } else if (extname(file) === '.md') {
      const markdown = readFileSync(filePath, 'utf8');
      const html = md.render(markdown);
      writeFileSync(filePath.replace('.md', '.html'), html);
    }
  });
}

convertDirectory('./doc');

```


# Task

Fix the following issue!

Rename build.js dor buildDoc.js
Factor the md = new MarkdownIt creation to createMarkdownRenderer.js
Similarly create convertDirectory.js


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

