#!/bin/sh
set -e
goal="Implement extractFileName.js correctly"
echo "Plan:"
echo "1. Create extractFileName.js in src/response/"
echo "2. Implement robust input format and file path validation"
echo "3. Remove unnecessary async and file system dependencies"

# Create and write the contents of extractFileName.js
cat > src/response/extractFileName.js << EOF
export function extractFileName(inputString) {
    // Check if input is a single line with a colon at the end
    if (!inputString.match(/^[^\\n]+:$/)) {
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
echo "\033[32mDone: $goal\033[0m\n"