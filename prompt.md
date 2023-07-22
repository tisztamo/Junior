# Working set

src/index.html:
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/frontend/index.jsx"></script>
</body>
</html>

```

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
  );
};

export default App;

```

src/frontend/components/ResetButton.jsx:
```
import { resetGit } from '../service/resetGit';

const ResetButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="w-full px-8 py-4 bg-red-600 text-white rounded" onClick={handleReset}>Reset Git</button>
  );
};

export default ResetButton;

```

src/frontend/components/ExecuteButton.jsx:
```
import { executeChange } from '../service/executeChange';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);

    console.log(response.message);
  };

  return (
    // Updated button color to a less flashy orange
    <button class="px-8 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;

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
    // Updated button label and added tailwind classes for larger button size
    <button class="px-8 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default StartButton;

```


# Task

Fix the following issue!

I accidentally added xxx to index.html, remove it.
All button width should be the same. Select a width the longest label of the three.
The reset button&#39;s color should be more vivid.


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

