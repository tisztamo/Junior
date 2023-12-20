#!/bin/sh
set -e
goal="Implement applyChangeBlocks and update extractFilePath without catching errors"
echo "Plan:"
echo "1. Rename extractFileName.js to extractFilePath.js and update the function name."
echo "2. Create applyChangeBlocks.js to process array of objects, allowing errors to escape."

# Rename extractFileName.js to extractFilePath.js and update the function name
mv src/response/extractFileName.js src/response/extractFilePath.js
cat > src/response/extractFilePath.js << EOF
export function extractFilePath(inputString) {
    // Check if input is a single line with a colon at the end
    if (!inputString.match(/^[^\n]+:$/)) {
        throw new Error('Input must be a single line with a colon at the end');
    }

    const filePath = inputString.slice(0, -1);

    // Regex to check for a valid relative file path
    const validPathRegex = /^(\.\/|..\/)?[\w-./]+$/;
    if (!validPathRegex.test(filePath)) {
        throw new Error('Invalid file path');
    }

    return filePath;
}
EOF

# Create applyChangeBlocks.js
cat > src/response/applyChangeBlocks.js << EOF
import { extractFilePath } from './extractFilePath.js';

export async function applyChangeBlocks(blocks) {
    blocks.forEach(block => {
        block.filePath = extractFilePath(block.previousParagraph);
    });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"