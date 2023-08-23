You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/frontend/components/RequirementsEditor.jsx:
```
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor } from '../model/promptDescriptor';
import { requirements, setRequirements } from '../model/requirements'; // Imported setRequirements
import { getYamlEntry } from '../service/getYamlEntry';

let lastPostedTime = 0;
let lastThrottledValue = null;

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    const now = Date.now();
    if (now - lastPostedTime < 1000) {
      lastThrottledValue = e.target.value; // Store the last throttled value
      setTimeout(() => {
        // Check after 1 second if lastThrottledValue is not null and send the request
        if (lastThrottledValue !== null) {
          postDescriptor({ requirements: lastThrottledValue });
          lastThrottledValue = null; // Reset the lastThrottledValue
        }
      }, 1000 - (now - lastPostedTime));
      return;
    }
    lastPostedTime = now;
    await postDescriptor({ requirements: e.target.value });
  };

  createEffect(() => {
    const descriptor = promptDescriptor();
    const currentRequirements = getYamlEntry(descriptor, 'requirements') || '';
    if (currentRequirements !== requirements()) {
      setRequirements(currentRequirements);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border mt-4">
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder="Enter your requirements..."
        value={requirements()}
        onInput={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;

```

src/frontend/model/requirements.js:
```
import { createSignal } from 'solid-js';

export const [requirements, setRequirements] = createSignal('');

```

src/frontend/model/promptDescriptor.js:
```
import { createSignal } from 'solid-js';

export const [promptDescriptor, setPromptDescriptor] = createSignal('');

```


# Task

Fix the following issue!

handleRequirementsChange should be binded to change events
and cleared: only the postDescriptor call is needed. Also remove the variables not needed anymore.
For input events, create a new handler which
  - reads the prompt descriptor
  - parses as yaml
  - updates the requirements section
  - writes back to the descriptor as string


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

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

