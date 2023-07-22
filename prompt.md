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
./package.json:
```
{
  "name": "@aijunior/dev",
  "version": "0.0.1",
  "description": "Your AI Contributor",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "src/main.js",
    "junior-web": "src/web.js"
  },
  "scripts": {
    "cli": "node src/main.js",
    "start": "node src/web.js",
    "build:css": "postcss ./src/frontend/styles.css -o ./dist/styles.css"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
  "dependencies": {
    "chatgpt": "^5.2.4",
    "clipboard-copy": "^4.0.1",
    "cors": "^2.8.5",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "js-yaml": "^4.1.0",
    "marked": "^5.1.0",
    "postcss-nested": "^6.0.1",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0",
    "ws": "^8.13.0"
  },
  "directories": {
    "doc": "doc"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  },
  "bugs": {
    "url": "https://github.com/tisztamo/Junior/issues"
  },
  "homepage": "https://github.com/tisztamo/Junior#readme",
  "devDependencies": {
    "@types/js-yaml": "^4.0.5",
    "autoprefixer": "^10.4.14",
    "babel-preset-solid": "^1.7.7",
    "postcss": "^8.4.26",
    "tailwindcss": "^3.3.3"
  }
}

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

# Task

Fix the following issue!

Remove everything from the doc directory, we restart our documentation
This is a monorepo, everything we ever write as documentation of this project, will go here
So we need a hierarchy of directories. Create it!

We want to write the docs in markdown, and generate html now and later other formats.

We will use some documentation tools, so we need to select and install them.

It would be great to host it on github pages, so we need to configure it.


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

