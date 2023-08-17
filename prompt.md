You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/frontend/service/postCommit.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message }),
  });

  const data = await response.json();

  return data;
};

export { postCommit };

```

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

src/frontend/components/CommitButton.jsx:
```
import { postCommit } from '../service/postCommit';
import postRequirements from '../service/postRequirements';
import { commitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import clearState from '../service/clearState';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    
    await postRequirements('');
    
    const status = await fetchGitStatus();
    console.log(status);
    clearState();
  };

  return (
    <button className="w-full px-4 py-4 bg-green-700 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```

src/backend/handlers/updateRequirementsHandler.js:
```
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

const updateRequirementsHandler = async (req, res) => {
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

export default updateRequirementsHandler;

```

src/frontend/service/postRequirements.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postRequirements = async (requirements) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/requirements`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ requirements }),
  });

  return await response.json();
};

export default postRequirements;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Also clear the attention section of the prompt descriptor after commit.
Rename the requirements route to descriptor (rename the file too) and make it accepting both sections. Only update the section that is provided in the request!
Also rename postRequirements!



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

