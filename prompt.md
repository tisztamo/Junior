# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── src/...

```
```
doc/
├── .DS_Store
├── assets/...
├── example.html
├── example.md
├── index.html
├── introduction.html
├── introduction.md
├── screenshot.png
├── web.html
├── web.md

```
doc/index.html:
```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Documentation</title>
  </head>
  <body>
    <h1>Welcome to our documentation!</h1>
    <p>Start with the <a href="introduction.html">introduction</a>.</p>
  </body>
</html>

    <p>Check out the <a href="web.html">Web Interface Guide</a>.</p>


```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Create roadmap.md with sections &#34;Usability &amp; fixes&#34;, &#34;Programming on mobile&#34;, &#34;Auto-attention&#34;, &#34;Prompt-herd refactors&#34;
- Link roadmap.html from index.html
- Fix index.html by moving the ill-placed link to the web guide into the body.
- Mention the project name &#34;Junior&#34; in index.html text and title
- Delete introduction.* and unlink from index.html
- npm run build:doc for generating html from md



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

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

