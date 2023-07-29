# Working set

doc/web.md:
```
# Web Interface

The Contributor project also provides a web interface to guide the AI model. It's designed for use with ChatGPT Pro and doesn't require an API key.

## Starting the Web Interface

Run the application with `npm start` to start a local server on port 3000. Open your web browser and navigate to `http://localhost:3000` to access the web interface.

## Workflow

The typical workflow begins with editing the `prompt.yaml` file in your code editor of choice (we recommend Visual Studio Code with the Junior plugin for an optimal experience). Once you're satisfied with your task setup, you proceed to the web interface for execution and monitoring.

## Usage

The web interface has a few interactive components:

![Web Interface](./screenshot.png)

- **Generate & Copy Prompt button**: Click this to generate a task prompt based on your `prompt.yaml` file and copy it to your clipboard.

- **Paste & Execute Change button**: Paste the generated prompt into the input field and click this button to execute the changes.

- **Roll Back to Last Commit button**: If you made a mistake or aren't happy with the changes, click this button to revert to the last commit.

- **Terminal**: Displays the output of your command execution. It's a simple console that shows the progress of the task.

For a more detailed guide on using the web interface, refer to our video tutorial [here](https://youtu.be/W_iwry8uT7E).

Remember, you can always refer to your `prompt.yaml` file to modify the task details or attention mechanism.

Happy developing with your AI contributor!

```


# Task

Improve the documentation!

npm run build:doc at the end!
Remove &#34;also&#34; from the first sentence!
Name the color of the buttons in their doc!

Rewrite to incorporate the following:
- The copied prompt should be pasted to chatGPT 4 or similar.
- What the model responds (a shell script) should be pasted to the orange Paste &amp; Execute Change button
- Rollback preserves prompt.yaml, but drops every change, including new files created in the meantime, even if not created by Junior.


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

