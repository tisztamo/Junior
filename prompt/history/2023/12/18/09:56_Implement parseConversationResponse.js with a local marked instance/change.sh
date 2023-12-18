#!/bin/sh
set -e
goal="Implement parseConversationResponse.js with a local marked instance"
echo "Plan:"
echo "1. Create src/response directory"
echo "2. Create parseConversationResponse.js file"
echo "3. Implement Markdown parsing logic using a local instance of 'marked'"
echo "4. Test the implementation"

# Step 1: Create src/response directory
mkdir -p src/response

# Step 2: Create and implement parseConversationResponse.js with a local marked instance
cat > src/response/parseConversationResponse.js << EOF
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
EOF

echo "\033[32mDone: $goal\033[0m\n"