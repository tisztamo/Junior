You are AI Junior, you code like Donald Knuth.

# Working set

./docs/index.html:
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="Description">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
  <link rel="icon" href="assets/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/lib/themes/vue.css">
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
  <div id="app"></div>
  <script src="docsifyConfig.js"></script>
  <!-- Docsify v4 -->
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
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
./docs/_coverpage.md:
```
# <span class="cover-color-blue">**You are the Pro,**</span> <span class="cover-color-orange">**Junior&nbsp;codes**</span>

Kraft code with the **Junior AI IDE**

<span class="cover-color-red">Works on large codebases,</span> <span class="cover-color-green">soon on your mobile phone.</span>

![](assets/logo.svg)

```
./docs/_sidebar.md:
```
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)
* [Open Jobs](./open_jobs.md)

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Meta/og for docs site


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: Debian


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

