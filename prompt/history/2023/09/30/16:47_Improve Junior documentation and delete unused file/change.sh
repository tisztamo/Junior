#!/bin/sh
set -e
goal="Improve Junior documentation and delete unused file"
echo "Plan:"
echo "1. Update env_or_cli.md with improved documentation."
echo "2. Delete the getPromptFlag.js file."

# Update env_or_cli.md
cat > ./docs/config/env_or_cli.md << EOF
# Junior Configuration

The Junior process can be started using the following commands:
- \`npx junior-web [args]\`
- \`npx junior-cli [args]\`
- For self-development from the git repo: \`npm start -- [args]\`.

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
npx junior-web --host=192.168.1.2
\`\`\`

### Ignoring a Directory from Attention Scan
\`\`\`
npx junior-cli --ignore=./myDirectory
\`\`\`

EOF

# Delete the getPromptFlag.js file
rm -f ./src/prompt/getPromptFlag.js

echo "\033[32mDone: $goal\033[0m\n"