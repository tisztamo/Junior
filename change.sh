#!/bin/sh
set -e
goal="Improve the web interface documentation"
echo "Plan:"
echo "1. Enhance explanation and user workflow in the 'Usage' section."
echo "2. Add an image and a video guide to the documentation."
echo "3. Run the npm command to build the new doc."

# Enhance the documentation by adding workflow, image, and video guide
cat << 'EOF' > doc/web.md
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
EOF

# Build the new documentation
npm run build:doc

echo "\033[32mDone: $goal\033[0m\n"
