import sanitize from 'sanitize-filename';

/**
 * Sanitize a filename or directory name to be safe for Windows paths.
 *
 * @param {string} name - The filename or directory name to sanitize.
 * @returns {string} - The sanitized name.
 */
export function sanitizeFilename(name) {
    if (typeof name !== 'string') {
        throw new TypeError('Filename must be a string');
    }

    // Use the sanitize-filename library to sanitize the filename
    const sanitized = sanitize(name).replace(/\s+/g, '_').replace(/_+/g, '_'); // Optional: Additional cleanup

    return sanitized || '_'; // Ensure non-empty filename
}
