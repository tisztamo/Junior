You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

```
docs/assets/
├── favicon.ico
├── logo.png
├── logo.svg
├── styles.css
├── video_cover.jpg

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
  nameLink: 'https://github.com/tisztamo/Junior',
  coverpage: true
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

/* Adding logo colors to cover page */
.cover-color-1 {
  color: rgb(59, 130, 246);
}

.cover-color-2 {
  color: rgb(253, 186, 116);
}

.cover-color-3 {
  color: rgb(185, 28, 28);
}

```

docs/cover.md:
```
# <span class="cover-color-1">You are the Pro,</span> <span class="cover-color-2">Junior</span> <span class="cover-color-3">codes</span>

Welcome to **Junior**, your AI-first IDE.


```


# Task

Improve the documentation!

1. Rename cover.md to _coverpage.md 2. Set the logo as the background in the cover by adding "![](assets/logo.svg)" to the end of the cover page


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

