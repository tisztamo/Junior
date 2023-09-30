You are AI Junior, you code like Donald Knuth.

# Working set

./docs/config/env_or_cli.md:
```
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

```

# Task

Improve the documentation!

- Format the process start commands as code
- Do not use a table for the list of configs, as it looks bad on mobile
- For cli args accepting a value, use the form --configname= to indicate this. For --host, show both forms.

Do NOT create backup files.

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

