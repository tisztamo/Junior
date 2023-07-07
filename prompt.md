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
src/frontend/App.jsx:
```
import { createSignal } from 'solid-js';
import PromptDescriptorViewer from './components/PromptDescriptorViewer'; // updated this line
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';

const App = () => {
  const [notes, setNotes] = createSignal('');
  const [prompt, setPrompt] = createSignal('');

  return (
    <>
      <PromptDescriptorViewer />
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
    </>
  );
};

export default App;

```

src/frontend/components/PromptDescriptorViewer.jsx:
```
import { createSignal, onMount } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';

const PromptDescriptorViewer = () => {
  const [descriptorContent, setDescriptorContent] = createSignal('');

  onMount(async () => {
    const text = await fetchDescriptor();
    setDescriptorContent(text);
  });

  return (
    <pre>{descriptorContent()}</pre>
  );
};

export default PromptDescriptorViewer;

```


# Task

Refactor the mentioned files!

Look for
  - unused imports
  - unneeded comments
  - ugly names
  - misplaced files
  - code repetition
  - code smell

When a file is bigger than 40 lines, split it: Identify the possible parts and create separate files!

Eliminate PromptDescriptorViewer.jsx, no need for it&#39;s functionality anymore!


# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

