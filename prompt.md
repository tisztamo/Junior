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
prompt/
├── format/...
├── system.md
├── task/...

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
src/backend/server.js:
```
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler } from './handlers.js';

const app = express();

app.use(cors());
app.use(express.json());

app.get('/descriptor', descriptorHandler);

app.post('/generate', generateHandler);

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

```

src/backend/handlers.js:
```
import processPrompt from '../prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};

export const descriptorHandler = servePromptDescriptor;

```

src/frontend/App.jsx:
```
import { createSignal } from 'solid-js';
import { marked } from 'marked';
import copy from 'clipboard-copy';
import { generatePrompt } from './generatePrompt';
import PromptDescriptorViewer from './PromptDescriptorViewer';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  const handleGeneratePrompt = async () => {
    const response = await generatePrompt(notes());

    copy(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <>
      <PromptDescriptorViewer />
      <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
      <button onClick={handleGeneratePrompt}>Start</button>
      <div innerHTML={prompt()}></div>
    </>
  );
};

export default App;

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

We need a way to select the task. The server should serve a list of tasks on a new endpoint, based on what it finds in the prompt/task directory recursively (list of relative paths). The client should display the list of tasks and allow the user to select one.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

