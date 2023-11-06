You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/files/FileViewer.jsx:
```
import SourceFileDisplay from '../files/SourceFileDisplay';
import FileViewerHeader from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50 bg-gray-500 bg-opacity-50">
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-emphasize w-full mx-2 max-h-full rounded-lg">
          <FileViewerHeader onClose={props.onClose} path={props.path} />
          <div class="overflow-y-auto h-full">
            <SourceFileDisplay path={props.path} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default FileViewer;

```
./src/frontend/components/files/SourceFileDisplay.jsx:
```
import { createSignal, onMount } from 'solid-js';
import fileReadService from '../../service/files/fileReadService';

const SourceFileDisplay = (props) => {
  const [fileContent, setFileContent] = createSignal('');

  const getLanguageFromPath = (path) => {
    const extension = path.split('.').pop().toLowerCase();
    return extension;
  };

  const fetchData = async () => {
    const data = await fileReadService(props.path);
    setFileContent(data);

    if (window.Prism) {
      const codeElement = document.querySelector('.source-display-code');
      const pre = codeElement.parentElement;

      const newCode = document.createElement('CODE');
      newCode.className = codeElement.className;
      newCode.textContent = data;

      window.Prism.highlightElement(newCode);
      pre.replaceChild(newCode, codeElement);
    }
  };

  onMount(() => {
    fetchData();
  });

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border w-full overflow-x-auto">
      <pre class={`language-${language}`} style={{ margin: 0 }}>
        <code class={`language-${language} source-display-code`}>{fileContent()}</code>
      </pre>
    </div>
  );
};

export default SourceFileDisplay;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

In FileViewer:
- Add h-full to the div with classes &#34;absolute inset-0&#34;
- Replace max-h-full with h-full
- Remove the wrapper around SourceFileDisplay

In SourceFileDisplay:
- Add &#34;overflow-y-auto h-full&#34; to the div with overflow-x-auto


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
EOF
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

