#!/bin/sh
set -e
goal="Improve documentation security and clarity"
echo "Plan:"
echo "1. Update --host description for clarity."
echo "2. Add security warning to --host usage."

cat > ./docs/config/env_or_cli.md << 'EOF'
# Junior Configuration

The Junior process can be started using the following commands:
- `junior-web [args]`
- `junior-cli [args]`

## Configurations

- **--ignore, JUNIOR_IGNORE**
  - List of items to ignore in a comma-separated format.
  - Defaults to: .git, node_modules, ./prompt, and many more. Check the getIgnoreList function for the full default list.
  - The final ignore list is a combination of the default list, command line arguments, and environmental variables.
  - Example: --ignore=./pathToIgnore

- **--backend-port, JUNIOR_BACKEND_PORT**
  - The port for the backend.
  - Default: 10101
  - Example: --backend-port=8080

- **--host**
  - Host configuration. If provided without a value, it enables hosting on all IPs.
  - **Warning**: Exposing your server publicly can be insecure. Use this setting only within a VPN or a secured local network. If in doubt, specify a trusted IP.
  - Example: --host (enables on all IPs) or --host=192.168.1.2

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

`junior-web --host=192.168.1.2`

### Ignoring a Directory from Attention Scan

`junior-cli --ignore=./myDirectory`

EOF

echo "\033[32mDone: $goal\033[0m\n"