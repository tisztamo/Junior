import fs from 'fs';
import path from 'path';
import util from 'util';
import { processPath } from './filesystem.js';
import { processInterfaceSection } from './processInterfaceSection.js';

const readFile = util.promisify(fs.readFile);

export const readAttention = async (attentionFilePath = "prompt/attention.txt", attentionRootDir = '.') => {
  try {
    const data = await readFile(path.join(attentionRootDir, attentionFilePath), "utf8");
    const lines = data.split("\n");
    const processedLines = await Promise.all(lines.map(line => {
      const trimmedLine = line.trim();
      if (trimmedLine.endsWith(' iface')) {
        const filePath = trimmedLine.slice(0, -6).trim();
        return processInterfaceSection(attentionRootDir, filePath);
      } else {
        return processPath(attentionRootDir, trimmedLine);
      }
    }));
    return processedLines.join("\n");
  } catch (error) {
    console.warn(error);
    throw new Error("Attention file is missing or unreadable!");
  }
};
