# attention.js

This module processes a reference file named 'attention.txt', which contains relative paths to different files and directories, and renders the current attention in Markdown.

## Interface

```js
async function readAttention(attentionFilePath = "prompt/attention.txt", attentionRootDir = '.') { ... }
```

This function takes two parameters:

- `attentionFilePath`: The path to the attention file, defaulting to 'prompt/attention.txt'.
- `attentionRootDir`: The root directory from where the paths in the attention file are relative, defaulting to '.'.

## Example

Here's an example of using this function:

```js
const attention = await readAttention();
console.log(attention); // Outputs the contents of files and directories listed in the 'attention.txt' file
```

## Implementation

The function reads the 'attention.txt' file and splits it into lines. Each line, representing a file or directory path, is processed using the `processPath` function defined in 'filesystem.js'. The processed lines, containing file contents or directory listings, are then joined with new lines and returned. If the 'attention.txt' file is missing or unreadable, the function throws an error.