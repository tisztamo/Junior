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
├── config.js
├── execute/...
├── frontend/...
├── index.html
├── interactiveSession/...
├── main.js
├── prompt/...
├── servePromptDescriptor.js
├── server.js
├── utils/...
├── vite.config.js

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

src/server.js:
```
import express from 'express';
import cors from 'cors';
import processPrompt from './prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

const app = express();

app.use(cors());
app.use(express.json());

app.get('/descriptor', servePromptDescriptor);

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

prompt.yaml should be displayed on the frontend. For this:
 - We need the backend to serve the file
 - We need a new component which will display the file as verbatim text.
  This component should be put before the notes input.



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

