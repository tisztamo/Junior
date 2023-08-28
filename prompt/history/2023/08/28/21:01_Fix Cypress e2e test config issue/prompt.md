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
src/frontend/
├── App.jsx
├── assets/...
├── components/...
├── config/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.html
├── index.jsx
├── model/...
├── postcss.config.cjs
├── service/...
├── startVite.js
├── styles/...
├── tailwind.config.cjs
├── vite.config.js

```
src/frontend/vite.config.js:
```
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: join(__dirname, 'postcss.config.cjs'),
  },
  build: {
    target: 'esnext',
  },
})

```

cypress.config.js:
```
import { defineConfig } from "cypress";

export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});

```

cypress/integration/showcase_test.js:
```
describe('Showcase Test', () => {
  it('should open the Junior frontend and check if it starts', () => {
    cy.visit('http://localhost:3000')  # assuming the frontend runs on this port
    cy.contains('NavBar')  # this is a very basic assertion, you should enhance it further when you expand on the tests.
  });
});

```


# Task

Fix the following issue!

When I run npm test,
I have to choose testing type. I select e2e.
Then I see "Create your first spec"
The spec pattern: cypress/e2e/**/*.cy.{js,jsx,ts,tsx}

Do you need other files to solve the task?



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


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

