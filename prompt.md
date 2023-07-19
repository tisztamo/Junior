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
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...

```
package.json:
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
    "start": "node src/web.js"
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
    "@types/js-yaml": "^4.0.5",
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

ko@MacBook-Pro-5 Junior % npm start
&gt; @aijunior/dev@0.0.1 start &gt; node src/web.js
node:internal/errors:477
    ErrorCaptureStackTrace(err);
    ^

Error [ERR_MODULE_NOT_FOUND]: Cannot find package &#39;ws&#39; imported from /Users/ko/projects-new/Junior/src/backend/startServer.js
    at new NodeError (node:internal/errors:388:5)
    at packageResolve (node:internal/modules/esm/resolve:910:9)
    at moduleResolve (node:internal/modules/esm/resolve:959:20)
    at defaultResolve (node:internal/modules/esm/resolve:1174:11)
    at ESMLoader.resolve (node:internal/modules/esm/loader:605:30)
    at ESMLoader.getModuleJob (node:internal/modules/esm/loader:318:18)
    at ModuleWrap.&lt;anonymous&gt; (node:internal/modules/esm/module_job:80:40)
    at link (node:internal/modules/esm/module_job:78:36) {
  code: &#39;ERR_MODULE_NOT_FOUND&#39;
}
Node.js v18.5.0



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

