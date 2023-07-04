You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

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

const app = express();

app.use(cors());
app.use(express.json());

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  // Return original markdown
  res.json({ prompt: prompt });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

```

src/frontend.jsx:
```
import { createSignal } from 'solid-js';
import { render } from 'solid-js/web';
import copy from 'clipboard-copy';
import { marked } from 'marked';

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

    // Copy original markdown to clipboard
    copy(data.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    // Convert markdown to HTML for display
    const htmlPrompt = marked(data.prompt);

    setPrompt(htmlPrompt);
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


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

When the prompt arrives to the frontend, copy it to the clipboard.  



# Output Format

A single shell script that creates everything is the preferred output

