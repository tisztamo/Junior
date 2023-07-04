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
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── run.sh
├── secret.sh
├── src/...
├── tmp/...

src/server.js:
```
import express from 'express';
import cors from 'cors';
import processPrompt from './prompt/promptProcessing.js';
import { marked } from 'marked';

const app = express();

app.use(cors());
app.use(express.json());

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  const htmlPrompt = marked(prompt);  // Convert markdown to HTML
  res.json({ prompt: htmlPrompt });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

```

src/frontend.jsx:
```
import { createSignal } from 'solid-js';
import { render } from 'solid-js/web';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  const generatePrompt = async () => {
    const response = await fetch('http://localhost:3000/generate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ notes: notes() })
    });

    const data = await response.json();
    setPrompt(data.prompt);
  };

  return (
    <>
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={generatePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
    </>
  );
};

render(App, document.getElementById('app'));

```

src/prompt/createPrompt.js:
```
import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
import yaml from 'js-yaml';
import ejs from 'ejs';
import { getPromptFlag } from './getPromptFlag.js';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await readFile(getPromptFlag() || "current_prompt.yaml", "utf8"));
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await ejs.renderFile(promptDescriptor.task, templateVars, {async: true});
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:




# Output Format

A single shell script that creates everything is the preferred output

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
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── run.sh
├── secret.sh
├── src/...
├── tmp/...

src/server.js:
```
import express from 'express';
import cors from 'cors';
import processPrompt from './prompt/promptProcessing.js';
import { marked } from 'marked';

const app = express();

app.use(cors());
app.use(express.json());

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  const htmlPrompt = marked(prompt);  // Convert markdown to HTML
  res.json({ prompt: htmlPrompt });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

```

src/frontend.jsx:
```
import { createSignal } from 'solid-js';
import { render } from 'solid-js/web';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  const generatePrompt = async () => {
    const response = await fetch('http://localhost:3000/generate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ notes: notes() })
    });

    const data = await response.json();
    setPrompt(data.prompt);
  };

  return (
    <>
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={generatePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
    </>
  );
};

render(App, document.getElementById('app'));

```

src/prompt/createPrompt.js:
```
import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
import yaml from 'js-yaml';
import ejs from 'ejs';
import { getPromptFlag } from './getPromptFlag.js';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await readFile(getPromptFlag() || "current_prompt.yaml", "utf8"));
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await ejs.renderFile(promptDescriptor.task, templateVars, {async: true});
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:




# Output Format

A single shell script that creates everything is the preferred output

