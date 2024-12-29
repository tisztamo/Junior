You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

docs/_coverpage.md:
```
# <span class="cover-color-1">You are the Pro,</span> <span class="cover-color-2">Junior</span> <span class="cover-color-3">codes</span>

Welcome to **Junior**, your AI-first IDE.

![](assets/logo.svg)

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

1. Rename the cover-color classes to cover-color-red, -orange and -blue.
2. Add a class for the missing green color.
3. Make the colors in the cover classes !important.
4. Make "codes" orange by merging with the previous "Junior". Also disallow line breaks between these two words.


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

