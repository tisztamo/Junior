You are AI Junior, you code like Donald Knuth.

# Task

Write unit tests!

Requirements:

Expected functionality:  parses a &#34;response&#34; string as markdown and returns a list of the code blocks and the paragraphs that preceed every code block. Return an array of  {code, lang, previousParagraph} objects.

Be sure to include several tests, including complex ones with multiple, different code blocks and other formatting.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- The backend has unit tests using Mocha and Chai. Unit test files are next to the tested ones with .test.js extension.

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

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

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
EOF
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

# Working set

src/response/parseConversationResponse.js:
```
import { marked } from 'marked';

export async function parseConversationResponse(response) {
    let previousParagraph = '';
    const results = [];

    // Create a local marked instance
    const localMarked = new marked.Markdown();
    localMarked.use({
        renderer: {
            code(code, lang) {
                results.push({ code, lang, previousParagraph });
                previousParagraph = '';
            },
            paragraph(text) {
                previousParagraph = text;
            }
        }
    });

    localMarked.parse(response);

    return results;
}

```
src/backend/sample.test.js:
```
import chai from 'chai';
const expect = chai.expect;

describe('Sample Test', function() {
  it('should pass', function() {
    expect(true).to.be.true;
  });
});

```