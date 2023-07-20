# Working set

src/frontend/generatePrompt.js:
```
import { getBaseUrl } from './getBaseUrl';

const generatePrompt = async (notes) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/generate`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes })
  });

  const data = await response.json();

  return data;
};

export { generatePrompt };

```

src/frontend/App.jsx:
```
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import { notes, setNotes } from './stores/notes';
import { prompt, setPrompt } from './stores/prompt';

const App = () => {
  return (
    <>
      <NotesInput notes={notes} setNotes={setNotes} />
      <StartButton notes={notes} setPrompt={setPrompt} />
      <PromptDisplay prompt={prompt} />
      <TasksList />
      <PromptDescriptor />
    </>
  );
};

export default App;

```

src/frontend/stores/prompt.js:
```
import { createSignal } from 'solid-js';

export const [prompt, setPrompt] = createSignal('');

```

src/frontend/components/PromptDisplay.jsx:
```
import { createSignal, onMount } from "solid-js";

const PromptDisplay = ({prompt}) => {
  let div;
  onMount(() => {
    div.innerHTML = prompt();
  });

  return (
    <div className="markdown" ref={div}></div>
  );
};

export default PromptDisplay;

```


# Task

Fix the following issue!

The generated prompt is copied to the clipboard, but the display fails to show anything.
The prompt signal should not be passed from app to display anyway. import it from the display too.


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

