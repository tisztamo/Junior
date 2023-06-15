import fs from 'fs';
import path from 'path';
import util from 'util';
import { processPath } from './filesystem.js';

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

async function processInterfaceSection(attentionRootDir, filePath) {
  const fullPath = path.join(attentionRootDir, filePath);
  const fileData = await readFile(fullPath, "utf8");
  const sections = fileData.split("##");
  const interfaceSection = sections.find(section => section.toLowerCase().includes("interface"));

  if (interfaceSection) {
    return `${filePath} iface:\n${interfaceSection.trim().substring(10)}`;
  } else {
    return fileData;
  }
}
