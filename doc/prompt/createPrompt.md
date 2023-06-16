# createPrompt.js

## Interface

The `prompt.js` module exports a single function, `createPrompt`, which is an asynchronous function that takes a single argument, `userInput`.

The `createPrompt` function uses the `prompt.yaml` file to determine the paths to the task, format, and attention files. The function reads the contents of these files and constructs a prompt string that is returned to the caller. The final prompt string is formatted as a Markdown document.

```javascript
import createPrompt from "./prompt/prompt.js";

createPrompt(userInput);
```

## Example(s)

Here's an example of how to use the `createPrompt` function:

```javascript
import createPrompt from "./prompt/prompt.js";

const userInput = "This is some user input";
createPrompt(userInput)
  .then(prompt => console.log(prompt))
  .catch(error => console.error(error));
```

This will output a Markdown formatted string, with sections for Attention, Task, Output Format, and user input, respectively.

## Implementation

The `createPrompt` function is implemented using the `fs` module's `readFile` function and the `js-yaml` library's `load` function. 

First, it reads the `prompt.yaml` file to get paths for the task, format, and attention files. Then, using these paths, it fetches the contents of the corresponding files. These content pieces are then formatted and stitched together into a single string, along with the user input, to form the final prompt. The prompt string is constructed as a Markdown document with headings for each section (Attention, Task, Output Format, User Input).
