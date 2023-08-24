You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/frontend/components/RequirementsEditor.jsx:
```
import { createSignal, createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import isBetaEnabled from '../service/config/isBetaEnabled'; 
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  const [isBeta, setIsBeta] = createSignal(false);

  const init = async () => {
    const betaStatus = await isBetaEnabled();
    setIsBeta(betaStatus);
  };

  createEffect(init);

  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
    setPromptDescriptor(updatedDescriptor);
  };

  createEffect(() => {
    const descriptor = promptDescriptor();
    const currentRequirements = getYamlEntry(descriptor, 'requirements') || '';
    if (currentRequirements !== requirements()) {
      setRequirements(currentRequirements);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-1 rounded border border-border mt-2">
      <AutoGrowingTextarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder={isBeta() ? "Enter your requirements..." : "This is disabled for now. Call with 'npx junior-web -- --beta' to enable."}
        value={isBeta() ? requirements() : ''}
        onInput={e => handleInput(e)}
        disabled={!isBeta()}
      />
    </div>
  );
};

export default RequirementsEditor;

```

src/frontend/service/postDescriptor.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postDescriptor = async (descriptor) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(descriptor),
  });

  return await response.json();
};

export default postDescriptor;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Add a new event handler: on change call postDecriptor with { requirements }
Leave the onInput handler as is.



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

