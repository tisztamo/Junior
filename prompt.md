# Working set

src/backend/routes/setupPromptRoutes.js:
```
import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateRequirementsHandler from '../handlers/updateRequirementsHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/requirements', updateRequirementsHandler);
  app.post('/updatetask', updateTaskHandler);
}

```

src/backend/handlers/updateRequirementsHandler.js:
```
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

export const updateRequirementsHandler = async (req, res) => {
  const requirements = req.body.requirements;
  
  try {
    const fileContent = await loadPromptDescriptor();
    const document = yaml.load(fileContent);
    document.requirements = requirements;
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Requirements updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

```


# Task

Fix the following issue!

file:///Users/ko/projects-new/Junior/src/backend/routes/setupPromptRoutes.js:4 import updateRequirementsHandler from &#39;../handlers/updateRequirementsHandler.js&#39;;
      ^^^^^^^^^^^^^^^^^^^^^^^^^
SyntaxError: The requested module &#39;../handlers/updateRequirementsHandler.js&#39; does not provide an export named &#39;default&#39;
    at ModuleJob._instantiate (node:internal/mod



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

