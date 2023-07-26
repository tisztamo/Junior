# Working set

src/backend/handlers/updateTaskHandler.js:
```
import { readFile, writeFile } from 'fs/promises';
import path from 'path';
import yaml from 'js-yaml';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const updateTaskHandler = async (req, res) => {
  const task = req.body.task;
  const filePath = path.resolve(__dirname, '../../../prompt.yaml');

  try {
    const fileContent = await readFile(filePath, 'utf-8');
    const document = yaml.load(fileContent);

    // assuming 'task' is a field in the yaml document
    document.task = path.join("prompt", "task", task);

    const newYamlStr = yaml.dump(document);
    await writeFile(filePath, newYamlStr, 'utf-8');
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

```

src/prompt/loadPromptDescriptor.js:
```
import fs from 'fs';
import util from 'util';

const readFile = util.promisify(fs.readFile);
import { descriptorFileName } from "./promptDescriptorConfig.js";

const loadPromptDescriptor = async (rawPrinter) => {
  const descriptorContent = await readFile(descriptorFileName, 'utf8');
  if (rawPrinter) {
    rawPrinter(descriptorFileName + ':\n' + descriptorContent);
  }
  return descriptorContent;
};

export { loadPromptDescriptor };

```


# Task

Fix the following issue!

Create savePromptDescriptor.js and use it and loadPromptDescriptor when updating the task. Do not use dirname.

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

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

