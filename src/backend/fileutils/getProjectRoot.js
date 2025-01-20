import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url'; // Explicitly import fileURLToPath.

let memoizedRoot = null;

function getProjectRoot() {
    if (memoizedRoot) {
        return memoizedRoot;
    }

    // Convert import.meta.url to a file path
    const currentFilePath = fileURLToPath(import.meta.url);
    let currentDir = path.dirname(currentFilePath);

    while (currentDir !== path.parse(currentDir).root) {
        if (fs.existsSync(path.join(currentDir, 'package.json'))) {
            memoizedRoot = currentDir;
            return memoizedRoot;
        }
        currentDir = path.dirname(currentDir);
    }

    throw new Error('Unable to find the project root containing package.json');
}

export default getProjectRoot;
