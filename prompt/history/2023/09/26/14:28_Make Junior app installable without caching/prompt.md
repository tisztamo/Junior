You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/index.html:
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="icon" href="/assets/favicon.ico" type="image/x-icon">
  <link href="https://unpkg.com/prism-themes@1.9.0/themes/prism-holi-theme.min.css" rel="stylesheet" />
  <title>Junior</title>
</head>
<body>
  <div id="app" class="bg-emphasize"></div>
  <script type="module" src="/index.jsx"></script>
  <script src="https://unpkg.com/prismjs@v1.x/components/prism-core.min.js"></script>
  <script src="https://unpkg.com/prismjs@v1.x/plugins/autoloader/prism-autoloader.min.js"></script>
</body>
</html>

```
./docs/README.md:
```
# Junior - Your AI-first IDE 

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

Junior is an **AI-first IDE** designed specifically for professional programmers who have a preference for customizing and fine-tuning their tools. 

With Junior, developers get a unique space where they can work hand-in-hand with AI throughout the development process. By using structured task descriptors and spotlighting relevant parts of a project, tasks like code implementation, documentation, and testing can be seamlessly delegated to Junior.

At its core, Junior embraces a design philosophy that prioritizes simplicity, configurability, and auditability. This ensures that the platform remains both accessible to its users and adaptable to a variety of use-cases.

Junior has been crafted exclusively with AI-powered coding right from its early days, way before its core functionalities were in place. This demonstrates Junior's pioneering approach to harnessing the potential of artificial intelligence in software development.

## Getting Started

For guidance on using Junior, please refer to [usage.md](usage.md).

## Contributing and Support

Your contributions make a difference! At Junior, we value the collaboration of the community. Your role as a contributor is to monitor the development, provide detailed prompts, and thoroughly review the generated outcomes.

For questions or assistance, please raise an issue in our GitHub repository.

**Note:** We've tested Junior primarily with the GPT-4 model. However, you're welcome to experiment with similarly capable models and share your findings. It's not compatible with GPT-3.5.

```
./src/frontend/index.jsx:
```
import "./styles/styles.css";
import { render } from 'solid-js/web';
import App from './App';

render(App, document.getElementById('app'));

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Make the app installable.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

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

