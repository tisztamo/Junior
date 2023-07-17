# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

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
    "contrib": "src/main.js"
  },
  "scripts": {
    "cli": "node src/main.js",
    "start": "node src/backend/server.js --prompt=prompt.yaml -s & vite src --open "
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
  "dependencies": {
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "clipboard-copy": "^4.0.1",
    "cors": "^2.8.5",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "js-yaml": "^4.1.0",
    "marked": "^5.1.0",
    "postcss": "^8.4.24",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.2",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0"
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
    "babel-preset-solid": "^1.7.7"
  }
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Rename the contrib bin command to junior, and add another one, &#34;junior-web&#34;
which does the same as &#34;npm start&#34;



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

