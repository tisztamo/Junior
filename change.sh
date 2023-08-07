#!/bin/sh
set -e
goal="Update application start command in docs"
echo "Plan:"
echo "1. Change the command to run the application from 'npm start' to 'npx junior-web' or 'npm start' from Junior itself."

cat << 'EOF' > docs/web.md
# Web Interface

Junior's web interface was designed for use with ChatGPT Pro and doesn't require an API key.

## Architecture

The web interface is composed of two different servers: a frontend and a backend. The frontend server runs on port 5173, and the backend server runs on port 10101.

## Starting the Web Interface

Run the application with `npx junior-web` from your project or with `npm start` from Junior itself. A web browser window will automatically open at `http://localhost:5173`, which is where you can access the web interface.

## Workflow

The typical workflow begins with editing the `prompt.yaml` file in your code editor of choice (we recommend Visual Studio Code with the Junior plugin for an optimal experience). Once you're satisfied with your task setup, you proceed to the web interface for execution and monitoring.

## Usage

The web interface has a few interactive components:

![Web Interface](./screenshot.png)

- **Generate & Copy Prompt button (Blue)**: Click this to generate a task prompt based on your `prompt.yaml` file and copy it to your clipboard. The copied prompt should be pasted to ChatGPT 4 or similar for execution.

- **Paste & Execute Change button (Orange)**: Paste the response from the AI model (a shell script) into the input field and click this button to execute the changes.

- **Roll Back to Last Commit button (Red)**: If you made a mistake or aren't happy with the changes, click this button to revert to the last commit. Please note, the rollback operation preserves the `prompt.yaml` file, but drops every change since the last commit, including new files created in the meantime, even if they were not created by Junior.

- **Terminal**: Displays the output of your command execution. It's a simple console that shows the progress of the task.

For a more detailed guide on using the web interface, refer to our video tutorial [here](https://youtu.be/W_iwry8uT7E).

Remember, you can always refer to your `prompt.yaml` file to modify the task details or attention mechanism.

At the end of your development, make sure to run `npm run build:doc` to regenerate the web.html document reflecting the latest changes.

Happy developing with your AI contributor!
EOF

echo "\033[32mDone: $goal\033[0m\n"
