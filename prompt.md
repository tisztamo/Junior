# Working set

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

src/frontend/components/PromptDisplay.jsx:
```
const PromptDisplay = ({prompt}) => {
  return (
    <div innerHTML={prompt()}></div>
  );
};

export default PromptDisplay;

```

src/frontend/styles.css:
```
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

```

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


# Task

Fix the following issue!

Since introducing tailwind, the prompt display (A markdown) has no meaningful style.
We need to introduce classes for this.

Create a meaningful styleset for the following html (generated from a markdown file)!
Find a place in the folder structure where it fits. Create the dir if missing.
Build on tailwind only if it makes it much easier.

&lt;div&gt;&lt;h1 id=&#34;working-set&#34;&gt;Working set&lt;/h1&gt;
&lt;p&gt;src/frontend/App.jsx:&lt;/p&gt;
&lt;pre&gt;&lt;code&gt;import NotesInput from &#39;./components/NotesInput&#39;;
import StartButton from &#39;./components/StartButton&#39;;
...
export default App;
&lt;/code&gt;&lt;/pre&gt;
&lt;h1 id=&#34;task&#34;&gt;Task&lt;/h1&gt;
&lt;p&gt;Fix the following issue!&lt;/p&gt;
&lt;p&gt;TaskList also displays the prompt descriptor. Refactor by creating a separate component for displaying the prompt desriptor and use it in App, not in taskslist! Also delete the unneeded src/frontend/components/TasksList.jsx.bak file!&lt;/p&gt;
&lt;h1 id=&#34;output-format&#34;&gt;Output Format&lt;/h1&gt;
&lt;p&gt;Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!&lt;/p&gt;
&lt;p&gt;EXAMPLE START&lt;/p&gt;
&lt;pre&gt;&lt;code class=&#34;language-sh&#34;&gt;#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
&lt;/code&gt;&lt;/pre&gt;
&lt;p&gt;EXAMPLE END&lt;/p&gt;
&lt;/div&gt;


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

