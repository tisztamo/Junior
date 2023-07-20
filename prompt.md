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
```
src/frontend/
├── App.jsx
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.jsx
├── service/...

```
src/frontend/App.jsx:
```
import { createSignal } from 'solid-js';
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;

```

src/frontend/index.jsx:
```
import { render } from 'solid-js/web';
import App from './App';

render(App, document.getElementById('app'));

```

src/vite.config.js:
```
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'

export default defineConfig({
  plugins: [solidPlugin()],
  build: {
    target: 'esnext',
  },
})

```

babel.config.js:
```
module.exports = {
  presets: [
    ["solid", { "generate": "dom", "hydratable": true, "delegateEvents": true }]
  ]
}

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

We want to use tailwindcss in our project. When configuring PostCSS plugin, the configuration expects an array, not an object. The project is configured to use es6 module imports without extension. Every js file is a module and uses .js extension. No need to install esm, node handles it. Remember: Always use ES6 exports and imports!



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

