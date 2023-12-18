import chai from 'chai';
import { parseConversationResponse } from './parseConversationResponse.js';
const expect = chai.expect;

describe('parseConversationResponse Function', function() {
  it('should correctly parse a single code block with a preceding paragraph', async function() {
    const md = 'This is a paragraph.\n\n```js\nconsole.log("Hello, world!");\n```';
    const result = await parseConversationResponse(md);
    expect(result).to.deep.equal([{ code: 'console.log("Hello, world!");', lang: 'js', previousParagraph: 'This is a paragraph.' }]);
  });

  it('should handle multiple code blocks with different languages', async function() {
    const md = 'First paragraph.\n\n```js\nconsole.log("JS Code");\n```\n\nSecond paragraph.\n\n```python\nprint("Python Code")\n```';
    const result = await parseConversationResponse(md);
    expect(result).to.deep.equal([
      { code: 'console.log("JS Code");', lang: 'js', previousParagraph: 'First paragraph.' },
      { code: 'print("Python Code")', lang: 'python', previousParagraph: 'Second paragraph.' }
    ]);
  });

  // Additional test cases can be added here
});

