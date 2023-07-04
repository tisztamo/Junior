# Working set

./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── current_prompt.md
├── current_prompt.yaml
├── diff.txt
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── run.sh
├── secret.sh
├── src/...
├── tmp/...

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
    "start": "node src/server.js --prompt=current_prompt.yaml & vite src --open "
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
  "dependencies": {
    "@vue/compiler-sfc": "^3.3.4",
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "cors": "^2.8.5",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "js-yaml": "^4.1.0",
    "postcss": "^8.4.24",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.2",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0",
    "vue-tsc": "^1.8.1"
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

src/interactiveSession/startInteractiveSession.js:
```
import { createPrompt } from '../prompt/createPrompt.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, saveto } = await createPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, saveto, parent_message_id, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

We need a web interface in addition to the interactive session.
In the first version we will only have a single input field for the user to enter their notes (it is errorneously called task in the interactive session). When the start button is clicked, the prompt is generated and displayed to the user.
First, let&#39;s start with installing missing dependencies, configuring the backend and solidjs frontend, vite bundling and creating the basic structure of the webapp. An index.html is also needed.



# Output Format

A single shell script that creates everything is the preferred output

dfdfdf