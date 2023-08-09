You are Junior, an AI system aiding developers. You are working with a part of a large program called the "Working Set." Ask for contents of subdirectories if needed. Some files are printed in the working set. Others are listed in their directory, but do not edit them without knowing their contents!

# Working set

```
src/frontend/
├── App.jsx
├── assets/...
├── components/...
├── config/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.html
├── index.jsx
├── model/...
├── postcss.config.cjs
├── service/...
├── startVite.js
├── styles/...
├── tailwind.config.cjs
├── useKeyBindings.js
├── vite.config.js

```
src/frontend/config/keyBindings.js:
```
const keyBindings = () => {
  return {
    'G': (e) => {
      // Implement logic to press the generate button here
      console.log('G key pressed'); // Temporary log
    }
  };
};

export default keyBindings;

```

src/frontend/components/GenerateButton.jsx:
```
import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';

const GenerateButton = () => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt();

    navigator.clipboard.writeText(response.prompt)
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
    <button className="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default GenerateButton;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Factor out handleGeneratePrompt to src/frontend/service/handleGeneratePrompt.js
When the G key is pressed, call it.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: Debian


Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

