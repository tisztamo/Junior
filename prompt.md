# Working set

scripts/convert-svg-to-png.cjs:
```
const sharp = require('sharp');
const fs = require('fs');

const inputSVGPath = 'docs/assets/logo.svg';
const outputPNGPath = 'docs/assets/logo.png';

sharp(inputSVGPath)
  .png()
  .toBuffer((err, buffer) => {
    if (err) throw err;
    fs.writeFileSync(outputPNGPath, buffer);
  });

```

package.json:
```
{
  "name": "@aijunior/dev",
  "version": "0.1.2",
  "description": "Your AI Contributor which codes itself",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "src/main.js",
    "junior-web": "src/web.js",
    "junior-init": "src/init.js"
  },
  "scripts": {
    "cli": "node src/main.js",
    "start": "node src/web.js",
    "build:css": "postcss ./src/frontend/styles.css -o ./dist/styles.css",
    "update-logo": "node ./scripts/convert-svg-to-png.cjs"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
  "dependencies": {
    "@types/js-yaml": "^4.0.5",
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "cors": "^2.8.5",
    "docsify-cli": "^4.4.4",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "highlight.js": "^11.8.0",
    "js-yaml": "^4.1.0",
    "markdown-it": "^13.0.1",
    "marked": "^5.1.0",
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "sharp": "^0.32.4",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.3",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0",
    "ws": "^8.13.0"
  },
  "directories": {
    "doc": "docs"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  },
  "bugs": {
    "url": "https://github.com/tisztamo/Junior/issues"
  },
  "homepage": "https://github.com/tisztamo/Junior#readme"
}

```


# Task

Refactor!

Rename the .cjs to updateLogo.js.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

