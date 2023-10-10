#!/bin/sh
set -e
goal="Improve Junior documentation per specified alterations"
echo "Plan:"
echo "1. Modify ./docs/config/env_or_cli.md to remove 'npx' and 'npm start' mentions."
echo "2. Adjust ./docs/web.md to ensure accuracy and clarity without 'npx' and 'npm start'."

# Modifying ./docs/config/env_or_cli.md
cat > ./docs/config/env_or_cli.md << EOF
# Junior Configuration

The Junior process can be started using the following commands:
- \`junior-web [args]\`
- \`junior-cli [args]\`

## Configurations

- **--ignore, JUNIOR_IGNORE**
  - List of items to ignore in a comma-separated format.
  - Defaults to: .git, node_modules, ./prompt, and many more. Check the getIgnoreList function for the full default list.
  - The final ignore list is a combination of the default list, command line arguments, and environmental variables.
  - Example: --ignore=./pathToIgnore

- **--server-port, JUNIOR_SERVER_PORT**
  - The port for the server.
  - Default: 10101
  - Example: --server-port=8080

- **--host**
  - Host configuration. If provided without a value, it enables the host. Otherwise, specify an IP.
  - Example: --host or --host=192.168.1.2

- **-d, --dry-run** (CLI Only)
  - Runs the application in dry run mode. Please note: the CLI is not fully functional at this time.

- **--model**
  - Specifies the model to be used.
  - Default: gpt-4
  - Example: --model=gpt-5

- **--noaudit**
  - Disables the audit trail.

- **--frontend-port, JUNIOR_FRONTEND_PORT**
  - The port for the frontend.
  - Default: 5864
  - Example: --frontend-port=8081

- **--system-prompt, -s** (CLI Only)
  - Forces the system prompt. Please note: the CLI is not fully functional at this time.

## Examples

### Hosting on a VPN IP
\`\`\`
junior-web --host=192.168.1.2
\`\`\`

### Ignoring a Directory from Attention Scan
\`\`\`
junior-cli --ignore=./myDirectory
\`\`\`
EOF

# Modifying ./docs/web.md
cat > ./docs/web.md << EOF
# Web Interface

Junior's web interface was designed for use with ChatGPT Pro and doesn't require an API key.

## Architecture

The web interface is composed of two different servers: a frontend and a backend. The frontend server runs on port 5864, and the backend server runs on port 10101.

## Starting the Web Interface

Run the application with \`junior-web\` from your project. A web browser window will automatically open at \`http://localhost:5864\`, which is where you can access the web interface.

For configuration options and details, refer to the [Configuration](./config/env_or_cli.md) documentation.

## Workflow

The typical workflow begins with editing the \`prompt.yaml\` file in your code editor of choice (we recommend Visual Studio Code with the Junior plugin for an optimal experience). Once you're satisfied with your task setup, you proceed to the web interface for execution and monitoring.

## Usage

The web interface has a few interactive components:

![Web Interface](./screenshot.png)

- **Generate & Copy Prompt button (Blue)**: Click this to generate a task prompt based on your \`prompt.yaml\` file and copy it to your clipboard. The copied prompt should be pasted to ChatGPT 4 or similar for execution.

- **Paste & Execute Change button (Orange)**: Paste the response from the AI model (a shell script) into the input field and click this button to execute the changes.

- **Roll Back to Last Commit button (Red)**: If you made a mistake or aren't happy with the changes, click this button to revert to the last commit. Please note, the rollback operation preserves the \`prompt.yaml\` file, but drops every change since the last commit, including new files created in the meantime, even if they were not created by Junior.

- **Commit Changes button (Green)**: After you're satisfied with your changes, click this button to commit your modifications to git.

- **Terminal**: Displays the output of your command execution. It's a simple console that shows the progress of the task.

For a more detailed guide on using the web interface, refer to our video tutorial [here](https://youtu.be/W_iwry8uT7E).

Remember, you can always refer to your \`prompt.yaml\` file to modify the task details or attention mechanism.

Happy developing with your AI contributor!
EOF

echo "\033[32mDone: $goal\033[0m\n"