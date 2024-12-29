#!/bin/sh
set -e
goal="Improving Junior Configuration Documentation"
echo "Plan:"
echo "1. Replace table format with a list format for better mobile readability."
echo "2. Format the process start commands as code."
echo "3. Add examples for each configuration that accepts values."

cat > ./docs/config/env_or_cli.md << EOF
# Junior Configuration

The Junior process can be started using the following commands:
- \`npx junior-web [args]\`
- \`npx junior-cli [args]\`
- For self-development from the git repo: \`npm start -- [args]\`.

## Configurations

- **--ignore, JUNIOR_IGNORE**
  - List of items to ignore.
  - Example: \`--ignore=./pathToIgnore\`

- **--server-port, JUNIOR_SERVER_PORT**
  - The port for the server.
  - Default: 10101
  - Example: \`--server-port=8080\`

- **--host**
  - Host configuration. If provided without a value, it enables the host. Otherwise, specify an IP.
  - Example: \`--host\` or \`--host=192.168.1.2\`

- **-d, --dry-run**
  - Runs the application in dry run mode.

- **--model**
  - Specifies the model to be used.
  - Default: gpt-4
  - Example: \`--model=gpt-5\`

- **--noaudit**
  - Disables the audit trail.

- **--frontend-port, JUNIOR_FRONTEND_PORT**
  - The port for the frontend.
  - Default: 5864
  - Example: \`--frontend-port=8081\`

- **--system-prompt, -s**
  - Forces the system prompt.

- **--prompt**
  - Flag related to the prompt configuration.

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

echo "\033[32mDone: $goal\033[0m\n"