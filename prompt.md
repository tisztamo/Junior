You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

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
```
src/
├── attention/...
├── backend/...
├── config.js
├── execute/...
├── frontend/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── utils/...
├── vite.config.js

```
package.json:
```
{
  "name": "gpcontrib",
  "version": "0.0.1",
  "description": "Build large documents with AI",
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
    "url": "git+https://github.com/tisztamo/contributor.git"
  },
  "bugs": {
    "url": "https://github.com/tisztamo/contributor/issues"
  },
  "homepage": "https://github.com/tisztamo/contributor#readme",
  "devDependencies": {
    "babel-preset-solid": "^1.7.7"
  }
}

```

src/server.js: err!

src/servePromptDescriptor.js: err!


# Task

## Refactor by split

A file is too big. We need to split it into parts.
Identify the possible parts and refactor the code in separate files!

The backend needs its own directory. Move server.js to it and split it into two. Also move servePromptDescriptor.js.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

