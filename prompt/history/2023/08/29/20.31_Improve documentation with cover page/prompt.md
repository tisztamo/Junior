You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

```
./
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── LICENSE.txt
├── README.md
├── change.sh
├── cypress/...
├── cypress.config.js
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── scripts/...
├── src/...

```
```
docs/
├── .nojekyll
├── README.md
├── _sidebar.md
├── assets/...
├── descriptor.md
├── docsifyConfig.js
├── index.html
├── open_jobs.md
├── roadmap.md
├── screenshot.png
├── usage.md
├── web.md

```
docs/README.md:
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

docs/docsifyConfig.js:
```
window.$docsify = {
  name: 'Junior',
  repo: 'https://github.com/tisztamo/Junior',
  loadSidebar: true,
  autoHeader: true,
  logo: "assets/logo.svg",
  nameLink: 'https://github.com/tisztamo/Junior'
}

```

docs/assets/styles.css:
```
.app-name-link img {
  max-width: 70px;
}

iframe {
  margin: 16px;
}

```

docs/assets/logo.svg:
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
    <rect x="0" y="0" rx="10" ry="10" width="100" height="30" style="fill:rgb(59 130 246);" />
    <rect x="0" y="33" rx="10" ry="10" width="100" height="30" style="fill:rgb(253, 186, 116);" />
    <rect x="0" y="66" rx="10" ry="10" width="48" height="34" style="fill:rgb(185, 28, 28);" />
    <rect x="52" y="66" rx="10" ry="10" width="48" height="34" style="fill:rgb(21, 128, 61);" />
</svg>

```


# Task

Improve the documentation!

Create a cover page for the docs, with "You are the Pro, Junior codes" as the main message. Use the logo colors extensively.


Do not create backup files.

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

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

