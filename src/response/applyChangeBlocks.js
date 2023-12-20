import { extractFilePath } from './extractFilePath.js';

export async function applyChangeBlocks(blocks) {
    blocks.forEach(block => {
        block.filePath = extractFilePath(block.previousParagraph);
    });
}
