/**
 * Sanitize a filename or directory name to be safe for Windows paths.
 * Replaces any disallowed characters with underscores (_).
 *
 * @param {string} name - The filename or directory name to sanitize.
 * @returns {string} - The sanitized name.
 */
export function sanitizeFilename(name) {
    if (typeof name !== 'string') {
        throw new TypeError('Filename must be a string');
    }

    // Define a regex for characters not allowed in Windows filenames
    const disallowedChars = /[<>:"/\\|?*'`]/g;
    let sanitized = name.replace(disallowedChars, '_').replace(/^\.\//, '_').replace(/\s+/g, '_');

    // Consolidate multiple underscores
    sanitized = sanitized.replace(/_+/g, '_');

    // Ensure the name is not empty or only underscores
    return sanitized || '_';
}
