#!/bin/sh
set -e
goal="Enhanced Unit Testing for parseConversationResponse Function"
echo "Plan:"
echo "1. Implement a local marked instance within parseConversationResponse.js function"
echo "2. Create parseConversationResponse.test.js with appropriate test cases"

# Updating parseConversationResponse.js
cat > src/response/parseConversationResponse.js << EOF
import { Marked } from 'marked';

export async function parseConversationResponse(response) {
    const localMarked = new Marked();
    let previousParagraph = '';
    const results = [];

    // Configure the localMarked instance with custom renderer
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
EOF

# Creating parseConversationResponse.test.js
cat > src/response/parseConversationResponse.test.js << EOF
import chai from 'chai';
import { parseConversationResponse } from './parseConversationResponse.js';
const expect = chai.expect;

describe('parseConversationResponse Function', function() {
  it('should correctly parse a single code block with a preceding paragraph', async function() {
    const md = 'This is a paragraph.\\n\\n\`\`\`js\\nconsole.log("Hello, world!");\\n\`\`\`';
    const result = await parseConversationResponse(md);
    expect(result).to.deep.equal([{ code: 'console.log("Hello, world!");', lang: 'js', previousParagraph: 'This is a paragraph.' }]);
  });

  it('should handle multiple code blocks with different languages', async function() {
    const md = 'First paragraph.\\n\\n\`\`\`js\\nconsole.log("JS Code");\\n\`\`\`\\n\\nSecond paragraph.\\n\\n\`\`\`python\\nprint("Python Code")\\n\`\`\`';
    const result = await parseConversationResponse(md);
    expect(result).to.deep.equal([
      { code: 'console.log("JS Code");', lang: 'js', previousParagraph: 'First paragraph.' },
      { code: 'print("Python Code")', lang: 'python', previousParagraph: 'Second paragraph.' }
    ]);
  });

  // Additional test cases can be added here
});

EOF

echo "\033[32mDone: $goal\033[0m\n"