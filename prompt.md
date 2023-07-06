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
```
src/frontend/
├── App.jsx
├── PromptDescriptorViewer.jsx
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── index.jsx

```
src/frontend/App.jsx:
```
import { createSignal } from 'solid-js';
import PromptDescriptorViewer from './PromptDescriptorViewer';
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


# Task

## Refactor by split

A file is too big. We need to split it into parts.
Identify the possible parts and refactor the code in separate files!

App.jsx is the file. We also need to stop the growth of it!



# Output Format

./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files should be heredoc.
Assume OSX. npm and jq are installed.

