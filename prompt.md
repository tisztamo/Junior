# Working set

src/frontend/App.jsx:
```
import NotesInput from './components/NotesInput';
import StartButton from './components/StartButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import { notes, setNotes } from './stores/notes';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <NotesInput notes={notes} setNotes={setNotes} />
        <StartButton notes={notes} setPrompt={setPrompt} />
        <ExecuteButton />
        <ResetButton />
        <PromptDisplay />
      </div>
    </div>
  );
};

export default App;

```

src/frontend/components/PromptDisplay.jsx:
```
import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../stores/prompt';

const PromptDisplay = () => {
  let div;

  createEffect(() => {
    if (div) {
      div.innerHTML = prompt();
    }
  });

  return (
    <div className="w-full max-w-screen overflow-x-auto whitespace-normal markdown" ref={div}></div>
  );
};

export default PromptDisplay;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Encapsulate the markdown in a html details tag, which remains closed until the user opens it.
Display the number of characters in the summary as &#34;prompt length: 12 chars&#34;
Move the display right under the start button.



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
OS: OSX
Installed tools: npm, jq
Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
# Plan:
# 1. [...]
# ...
# N. echo "Completed: $goal\n"

[Commands solving the task]
```

EXAMPLE END

