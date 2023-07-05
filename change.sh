#!/bin/bash

# Step 1: Create the new file for serving the prompt.yaml file
cat <<EOF > ./src/servePromptDescriptor.js
import { readFile } from 'fs/promises';
import path from 'path';

export const servePromptDescriptor = async (req, res) => {
  const file = await readFile(path.resolve(__dirname, '../prompt.yaml'), 'utf-8');
  res.send(file);
};
EOF

# Step 2: Update server.js file to use the servePromptDescriptor function
cat <<EOF > ./src/server.js
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
EOF

# Step 3: Create the new PromptDescriptorViewer.jsx component
cat <<EOF > ./src/frontend/PromptDescriptorViewer.jsx
import { createSignal, onMount } from 'solid-js';

const PromptDescriptorViewer = () => {
  const [descriptorContent, setDescriptorContent] = createSignal('');

  onMount(async () => {
    const response = await fetch('/descriptor');
    const text = await response.text();
    setDescriptorContent(text);
  });

  return (
    <pre>{descriptorContent()}</pre>
  );
};

export default PromptDescriptorViewer;
EOF

# Step 4: Update App.jsx to use the new PromptDescriptorViewer component
cat <<EOF > ./src/frontend/App.jsx
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
EOF

echo "Done."
