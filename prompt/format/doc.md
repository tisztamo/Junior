## Markdown Documenation Guide

Each .js module needs an accompanying .md file that describes it in concise and simple english.

The description has the following sections:

- Interface
- Example(s)
- Implementation

Example:

doc/extractCode.md:
```md
# extractCode.js

This module is designed to extract shell commands enclosed in "```sh" and "```" markdown code block tags from a response string. 

## Interface

```js
function extractCode(res) { ... }
```

This function takes a single parameter:

- `res`: A string from which the shell command will be extracted.

## Example

Here's an example of using this function:

```js
const response = 'Here is your command:\n```sh\nls -l\n```';
const command = extractCode(response);
console.log(command); // Outputs: 'ls -l'
```

## Implementation

The function operates by matching the input string against a regular expression that looks for markdown code block tags specifying a shell command (`sh`). If it finds a match, it returns the content within the markdown code block tags after trimming whitespace. If no match is found, it returns null. This function does not perform any error checking or validation on the contents of the code block.

```