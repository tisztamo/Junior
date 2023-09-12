You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/MultiSelect/FullScreenPopup.jsx:
```
import SourceFileDisplay from '../files/SourceFileDisplay';

const FullScreenPopup = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-3/4 h-3/4 rounded-lg overflow-y-auto">
          <button class="absolute top-4 right-4" onClick={props.onClose}>Close</button>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FullScreenPopup;

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
  };

  onMount(fetchData);

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border w-full overflow-x-auto">
      <pre class="m-0"><code class={`language-${language}`}>{fileContent()}</code></pre>
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

1. Make the source display popup w-full mx-2 (it should remain h-3/4)
2. Remove the "close" label, it should just close on any click.
3. Prism is not running on newly created source viewers. Do we need to call something on mount? (Prism is loaded from a cdn in the html)


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
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


