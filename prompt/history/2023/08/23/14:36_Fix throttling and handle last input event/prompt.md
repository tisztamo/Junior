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
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    setRequirements(e.target.value);
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

src/backend/handlers/updateDescriptorHandler.js:
```
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

const updateDescriptorHandler = async (req, res) => {
  const { requirements, attention } = req.body;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);

    if (requirements !== undefined) {
      document.requirements = requirements;
    }
    
    if (attention !== undefined) {
      document.attention = attention;
    }
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Descriptor updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

export default updateDescriptorHandler;

```


# Task

Fix the following issue!

Remove the call to setRequirements from handleRequirementsChange
Add throttling handleRequirementsChange: Do not post more than once per second



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

