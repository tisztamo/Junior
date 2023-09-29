# Junior Configuration

This document outlines the possible configurations for the Junior application. These configurations can be provided via command-line arguments or environment variables. The Junior process can be started using npx junior-web [args], npx junior-cli [args], or, for self-development from the git repo: npm start -- [args].

## Table of Configurations
| Argument / Environment Variable | Description |
|---------------------------------|-------------|
| --ignore, JUNIOR_IGNORE | List of items to ignore. |
| --server-port, JUNIOR_SERVER_PORT | The port for the server. Default is 10101. |
| --host | Host configuration. If --host is provided without a value, it simply enables the host. Otherwise, it can be provided an IP. |
| -d, --dry-run | Runs the application in dry run mode. |
| --model | Specifies the model to be used. Default is gpt-4. |
| --noaudit | Disables the audit trail. |
| --frontend-port, JUNIOR_FRONTEND_PORT | The port for the frontend. Default is 5864. |
| --system-prompt, -s | Forces the system prompt. |
| --prompt | Flag related to the prompt configuration. |

## Examples

### Hosting on a VPN IP
```
npx junior-web --host=192.168.1.2
```

### Ignoring a Directory from Attention Scan
```
npx junior-cli --ignore=./myDirectory
```
