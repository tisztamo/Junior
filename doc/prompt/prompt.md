# Interface

This is an asynchronous function that takes a task description and returns a string to be used as an AI prompt. The output string is composed of the current attention appended with the task description, if any.

# Example(s)

```javascript
import createQuery from 'prompt/prompt.js';

async function example() {
    let task = 'Generate documentation';
    let prompt = await createQuery(task);
    console.log(prompt);
}

example();
```

In the above example, we import the `createQuery` function from the 'prompt/prompt.js' module. We then use this function to generate a prompt from the task description 'Generate documentation'. The prompt string is then logged to the console.

# Implementation

The `createQuery` function uses the `readAttention` function from the '../attention/attention.js' module to get the current attention. The task description is appended to this attention string with a newline character in between if the task description exists. The composed string is then returned as the output. 
