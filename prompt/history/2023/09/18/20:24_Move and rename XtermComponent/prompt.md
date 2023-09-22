You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/XtermComponent.jsx:
```
import { onCleanup, onMount } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';

const XtermComponent = () => {
  let container;
  const term = new Terminal();
  
  onMount(() => {
    term.open(container);
  });
  
  // Ensure terminal instance gets destroyed on component cleanup
  onCleanup(() => {
    term.dispose();
  });

  return (
    <div class="rounded border p-4" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default XtermComponent;

```

./src/frontend/App.jsx:
```
import { onCleanup } from 'solid-js';
import useKeyBindings from './service/useKeyBindings';
import keyBindings from './config/keyBindings';
import NavBar from './components/NavBar';
import PromptCreation from './components/PromptCreation';
import ChangeExecution from './components/ChangeExecution';
import ChangeInspection from './components/ChangeInspection';
import ChangeFinalization from './components/ChangeFinalization';
import XtermComponent from './components/XtermComponent'; // Newly added import

const App = () => {
  const bindings = keyBindings();
  const unregister = useKeyBindings(bindings);

  onCleanup(unregister); 

  return (
    <div class="bg-main min-h-screen max-w-desktop lg:max-w-desktop md:max-w-full sm:max-w-full xs:max-w-full mx-auto flex flex-col items-center space-y-8 px-2 sm:px-4 xs:px-4 pb-8">
      <NavBar />
      <PromptCreation />
      <ChangeExecution />
      <ChangeInspection />
      <ChangeFinalization />
      <XtermComponent /> {/* Newly added component */}
    </div>
  );
};

export default App;

```


# Task

Move the following files to the specified target dirs!

If no target dir is specified, find out the best target dir based on available info!

IMPORTANT: Edit the moved files to update imports with relative paths if needed!

You need to follow dependencies to maintain coherence. Update imports!

- create frontend/components/terminal/
- move XtermComponent.jsx there and rename it TerminalComponent.jsx


## Project Specifics

- Every js file should *only export a single function or signal, as default*! eg.: in createGitRepo.js: export default function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


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


