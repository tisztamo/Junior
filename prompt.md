# Working set

```
src/frontend/
├── App.jsx
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.jsx
├── service/...
├── stores/...
├── styles/...

```
src/frontend/App.jsx:
```
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay />
      <TasksList />
      <PromptDescriptor />
    </>
  );
};

export default App;

```

tailwind.config.js:
```
export default {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.tsx', './src/**/*.ts'],
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}

```


# Task

Fix the following issue!

We need margins on large screens and a responsive layout.
When looking at the page, after loading (empty prompt, prompt descriptor loaded), the prompt descriptor (A yaml file) should be the first element catching our eyes.
Under that the notes input, and the start button so that it is easy to click after entering the notes.
Over the prompt descriptor is the task list (a html select).
When we click the button, the prompt is generated and displayed. It&#39;s a markdown. Display at the bottom.


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

