#!/bin/sh
set -e
goal="Generate docs/config/env_or_cli.md for Junior configurations"
echo "Plan:"
echo "1. Create the directory structure for the documentation."
echo "2. Create the intro and structure for the documentation."
echo "3. Extract and document configurations from the working set."
echo "4. Add examples to the documentation."

# Create the directory structure for the documentation
mkdir -p docs/config/

# Create the intro and structure for the documentation
cat > docs/config/env_or_cli.md << EOF
# Junior Configuration

This document outlines the possible configurations for the Junior application. These configurations can be provided via command-line arguments or environment variables. The Junior process can be started using npx junior-web [args], npx junior-cli [args], or, for self-development from the git repo: npm start -- [args].

## Table of Configurations
| Argument / Environment Variable | Description |
|---------------------------------|-------------|
EOF

# Extract and document configurations from the working set

# getIgnoreList.js
echo "| --ignore, JUNIOR_IGNORE | List of items to ignore. |" >> docs/config/env_or_cli.md

# getServerPort.js & serverConfig.js
echo "| --server-port, JUNIOR_SERVER_PORT | The port for the server. Default is 10101. |" >> docs/config/env_or_cli.md

# configHandler.js
# No direct configurations

# hostConfig.js
echo "| --host | Host configuration. If --host is provided without a value, it simply enables the host. Otherwise, it can be provided an IP. |" >> docs/config/env_or_cli.md

# config.js
echo "| -d, --dry-run | Runs the application in dry run mode. |" >> docs/config/env_or_cli.md
echo "| --model | Specifies the model to be used. Default is gpt-4. |" >> docs/config/env_or_cli.md

# AuditTrailConfig.js
echo "| --noaudit | Disables the audit trail. |" >> docs/config/env_or_cli.md

# getFrontendPort.js
echo "| --frontend-port, JUNIOR_FRONTEND_PORT | The port for the frontend. Default is 5864. |" >> docs/config/env_or_cli.md

# createApi.js
# No direct configurations beyond OPENAI_API_KEY which is already implicitly covered

# getSystemPromptIfNeeded.js
echo "| --system-prompt, -s | Forces the system prompt. |" >> docs/config/env_or_cli.md

# getPromptFlag.js
echo "| --prompt | Flag related to the prompt configuration. |" >> docs/config/env_or_cli.md

# Add examples to the documentation

cat >> docs/config/env_or_cli.md << EOF

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