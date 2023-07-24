# Working set

src/frontend/App.jsx:
```
import StartButton from './components/StartButton';
import ExecuteButton from './components/ExecuteButton';
import ResetButton from './components/ResetButton';
import PromptDisplay from './components/PromptDisplay';
import TasksList from './components/TasksList';
import PromptDescriptor from './components/PromptDescriptor';
import NavBar from './components/NavBar';
import { setPrompt } from './stores/prompt';

const App = () => {
  return (
    <div class="m-2">
      <div class="max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 sm:p-0">
        <NavBar />
        <TasksList />
        <PromptDescriptor />
        <StartButton setPrompt={setPrompt} />
        <PromptDisplay />
        <ExecuteButton />
        <ResetButton />
      </div>
    </div>
  );
};

export default App;

```

src/frontend/components/StartButton.jsx:
```
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import copy from 'clipboard-copy';

const StartButton = ({setPrompt}) => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt();

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

Rename StartButton to GenerateButton and do not pass setPrompt to it, it can import itself.



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

