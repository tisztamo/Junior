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
        <PromptDisplay />
        <ExecuteButton />
        <ResetButton />
      </div>
    </div>
  );
};

export default App;

```

src/frontend/stores/notes.js:
```
import { createSignal } from 'solid-js';

export const [notes, setNotes] = createSignal('');

```

src/frontend/components/NotesInput.jsx:
```
import { createSignal } from 'solid-js';

const NotesInput = () => {
  const [notes, setNotes] = createSignal('');
  
  return (
    <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
  );
};

export default NotesInput;

```

src/frontend/components/StartButton.jsx:
```
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';

const StartButton = ({notes, setPrompt}) => {
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
    <button class="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default StartButton;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Fully eliminate the notes input feature!



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

