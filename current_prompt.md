You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

src/attention/processFile.js:
```
import fs from 'fs'
import path from 'path'
import util from 'util'

const readFile = util.promisify(fs.readFile)

export const processFile = async (root, p) => {
  const fullPath = path.join(root, p)
  try {
    const content = await readFile(fullPath, "utf8")
    return `${p}:\n\`\`\`\n${content}\n\`\`\`\n`
  } catch (error) {
    return `${p}: err!\n`
  }
}

```


# Task

Implement the following feature!

- Write a plan first, only implement after the plan is ready!
- Create new files when needed!
- Every js js file should only export a single function!

Requirements:

When printing the contents of a file in the attention, use markdown code blocks. E.g.: dir/sample.txt: ``` This is the contents of the file. ``` Also find a better name for filesystem.js!



# Output Format

Provide the new or modified file(s) as code blocks, each prefixed with its path and a colon.
Always output full files, copying unchanged content.

E.g.:

texts/sample.txt:
```
A sample text file.
```


