You are AI Junior, you code like Donald Knuth.

# Working set

./docs/config/env_or_cli.md:
```
# Junior Configuration

The Junior process can be started using the following commands:
- `npx junior-web [args]`
- `npx junior-cli [args]`
- For self-development from the git repo: `npm start -- [args]`.

## Configurations

- **--ignore, JUNIOR_IGNORE**
  - List of items to ignore.
  - Example: `--ignore=./pathToIgnore`

- **--server-port, JUNIOR_SERVER_PORT**
  - The port for the server.
  - Default: 10101
  - Example: `--server-port=8080`

- **--host**
  - Host configuration. If provided without a value, it enables the host. Otherwise, specify an IP.
  - Example: `--host` or `--host=192.168.1.2`

- **-d, --dry-run**
  - Runs the application in dry run mode.

- **--model**
  - Specifies the model to be used.
  - Default: gpt-4
  - Example: `--model=gpt-5`

- **--noaudit**
  - Disables the audit trail.

- **--frontend-port, JUNIOR_FRONTEND_PORT**
  - The port for the frontend.
  - Default: 5864
  - Example: `--frontend-port=8081`

- **--system-prompt, -s**
  - Forces the system prompt.

- **--prompt**
  - Flag related to the prompt configuration.

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
./src/backend/fileutils/getIgnoreList.js:
```
function getIgnoreList() {
  const DEFAULT_IGNORE = [
    '.git',
    'node_modules',
    './prompt',
    'dist',
    'build',
    'tmp',
    'temp',
    '.vscode',
    '.idea',
    'coverage',
    '.env',
    '.DS_Store',
    'logs',
    'package-lock.json',
    'yarn.lock',
    '*.pyc',
    '__pycache__',
    '.venv',
    'venv',
    'target',
    '*.class',
    '*.exe',
    '*.test',
    'vendor/',
    '*.gem',
    '.bundle',
    'Gemfile.lock',
    'Cargo.lock',
    'bin/',
    'obj/',
    '*.suo',
    '*.user',
    '*.xcodeproj',
    '*.xcworkspace',
    'Pods/',
    'pubspec.lock',
    '.dart_tool/',
    'out/',
    '*.tsbuildinfo',
    '*.Rproj.user',
    '*.Rhistory',
    '*.pl~',
    'cpanfile.snapshot',
    'project/',
    'dist/',
    '*.hi',
    '_build/',
    'deps/',
    '*.log',
    '*.asv'
  ];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  const totalIgnore = [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];

  const nameIgnore = totalIgnore.filter(item => !item.startsWith('./'));
  const pathIgnore = totalIgnore.filter(item => item.startsWith('./')).map(item => item.slice(2));

  return { nameIgnore, pathIgnore };
}

export default getIgnoreList;

```
./src/prompt/getPromptFlag.js:
```
function getPromptFlag() {
  const promptFlag = process.argv.find(arg => arg.startsWith("--prompt="));
  if (promptFlag) {
    return promptFlag.split("=")[1];
  }
}

export { getPromptFlag };

```

# Task

Improve the documentation!

Add more info:

1. --ignore accepts a comma-separated list of paths to be ignored from the attention scan. List the defaults and describe how the different sources are merged.

2. the --prompt flag is not used, remove from the docs and delete getPromptFlag.js

3. -s and -d and their long variants are only used in the cli. Spearate them and add a note that the cli is not fully functional at the time.

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

