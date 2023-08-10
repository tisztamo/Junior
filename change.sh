#!/bin/sh
set -e
goal="Remove try-catch block in readAttention.js"
echo "Plan:"
echo "1. Modify readAttention.js to remove the try-catch, allowing errors to propagate"
cat << 'EOF' > src/attention/readAttention.js
import { processFile } from './processFile.js';
import { processInterfaceSection } from './processInterfaceSection.js';
import { printFolderStructure } from './printFolderStructure.js';

export const readAttention = async (attentionArray = [], attentionRootDir = '.') => {
  if (!attentionArray) {
    return [];
  }
  const processedLines = await Promise.all(attentionArray.map(line => {
    const trimmedLine = line.trim();
    if (trimmedLine.endsWith(' iface')) {
      const filePath = trimmedLine.slice(0, -6).trim();
      return processInterfaceSection(attentionRootDir, filePath);
    } else if (trimmedLine.endsWith('/')) {
      return printFolderStructure(attentionRootDir, trimmedLine.slice(0, -1).trim());
    } else {
      return processFile(attentionRootDir, trimmedLine);
    }
  }));
  return processedLines;
};
EOF
echo "\033[32mDone: $goal\033[0m\n"
