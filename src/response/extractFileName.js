export function extractFileName(inputString) {
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
