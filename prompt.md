# Working set

doc/web.md:
```
# Web Interface

The Contributor project also provides a web interface to guide the AI model. It's designed for use with ChatGPT Pro and doesn't require an API key.

## Starting the Web Interface

Run the application with `npm start` to start a local server on port 3000. Open your web browser and navigate to `http://localhost:3000` to access the web interface.

## Usage

The web interface has a few interactive components:

- **Generate & Copy Prompt button**: Click this to generate a task prompt based on your `prompt.yaml` file and copy it to your clipboard.

- **Paste & Execute Change button**: Paste the generated prompt into the input field and click this button to execute the changes.

- **Roll Back to Last Commit button**: If you made a mistake or aren't happy with the changes, click this button to revert to the last commit.

- **Terminal**: Displays the output of your command execution. It's a simple console that shows the progress of the task.

Remember, you can always refer to your `prompt.yaml` file to modify the task details or attention mechanism.

Happy developing with your AI contributor!

```


# Task

Improve the documentation!

npm run build:doc at the end!

Add an image: ./screenshot.png
Add a video: https://youtu.be/W_iwry8uT7E

At the beginning of usage write about the workflow: Edit prompt.yaml with vscode, using the Junior plugin, then going to the web interface to continue.


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

