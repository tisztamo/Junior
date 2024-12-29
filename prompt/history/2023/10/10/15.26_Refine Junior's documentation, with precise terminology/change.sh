#!/bin/sh
set -e

goal="Refine Junior's documentation, with precise terminology"
echo "Plan:"
echo "1. Correct ChatGPT naming"
echo "2. Remove the architecture section"
echo "3. Redefine the workflow section with appropriate 'execution' usage"

# Modifying the documentation according to the task specifications.
cat > ./docs/web.md << 'EOF'
# Web Interface

Junior's web interface was designed for use with ChatGPT Plus and doesn't require an API key.

## Starting the Web Interface

Run the application with `junior-web` from your project. A web browser window will automatically open at `http://localhost:5864`, which is where you can access the web interface.

For configuration options and details, refer to the [Configuration](./config/env_or_cli.md) documentation.

## Workflow

The updated workflow is straightforward and designed to enhance your development process efficiently. Start by running `junior-web` from your project directory, then open your web browser and go to `http://localhost:5864`. Within the web interface:
- Input your task requirements.
- Select the appropriate attention files.
- Click on the "Generate & Copy Prompt" button to produce a task prompt that will then be utilized by ChatGPT Plus.
- Paste the output from ChatGPT Plus into the web interface and execute the resulting shell script to enact the proposed changes.

## Usage

The web interface comes with several interactive components:

![Web Interface](./screenshot.png)

- **Generate & Copy Prompt button (Blue)**: Click this to generate a task prompt and copy it to your clipboard. Subsequently, paste it into ChatGPT Plus for processing.

- **Paste & Execute Change button (Orange)**: Paste the ChatGPT Plus output (a shell script) into the input field and click this button to execute the changes.

- **Roll Back to Last Commit button (Red)**: If you made a mistake or are unsatisfied with the changes, click this button to revert to the last commit. Be aware that the rollback operation maintains the `prompt.yaml` file but discards every change since the last commit, including newly created files, even if they were not created by Junior.

- **Commit Changes button (Green)**: Once you've verified and are satisfied with the changes, click this button to commit your modifications to git.

- **Terminal**: Displays the output of your command execution. It's a basic console that visually communicates the task’s progress.

For a more detailed guide on using the web interface, refer to our video tutorial [here](https://youtu.be/W_iwry8uT7E).

Remember, you can always refer to your `prompt.yaml` file to modify the task details or attention mechanism.

Happy developing with your AI contributor!
EOF

echo "\033[32mDone: $goal\033[0m\n"