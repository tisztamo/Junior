You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

```
docs/
├── .nojekyll
├── README.md
├── README.md.backup
├── _sidebar.md
├── _sidebar_backup.md
├── assets/...
├── descriptor.md
├── docsifyConfig.js
├── index.html
├── roadmap.md
├── screenshot.png
├── usage.md
├── web.md

```
```
src/
├── attention/...
├── backend/...
├── command/...
├── config.js
├── doc/...
├── execute/...
├── frontend/...
├── git/...
├── init.js
├── interactiveSession/...
├── llm/...
├── main.js
├── prompt/...
├── web.js

```
docs/index.html:
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

docs/_sidebar.md:
```
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)

```

docs/README.md:
```
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI-first IDE 

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

Junior is an **AI-first IDE** designed to utilize the capabilities of language models. Much like how Linus Torvalds oversees Linux Kernel development, Junior provides a space for developers to collaborate directly with AI throughout the development process.

Embracing a design philosophy of being simple, configurable and auditable, Junior aims to join the ranks of influential tools such as git and LISP in terms of its contribution to software development.

With a structured task descriptor and by spotlighting relevant parts of your project, you can delegate tasks such as code implementation, documentation, testing, and more, to Junior.

## Getting Started

For guidance on using Junior, please refer to [usage.md](usage.md).

## Contributing and Support

Your contributions make a difference! At Junior, we value the collaboration of the community. Your role as a contributor is to monitor the development, provide detailed prompts, and thoroughly review the generated outcomes.

For questions or assistance, please raise an issue in our GitHub repository.

**Note:** We've tested Junior primarily with the GPT-4 model. However, you're welcome to experiment with similarly capable models and share your findings. It's not compatible with GPT-3.5.


```


# Task

Improve the documentation!

remove files: docs/*backup*
remove dir: src/doc/
In readme, instead of writing about lisp and git,
write that Junior targets craftmans, aka professional programmers who like to tweak their tools. (Reword this)


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: Debian


Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

