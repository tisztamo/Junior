import fs from 'fs';
import path from 'path';
import util from 'util';

const readFile = util.promisify(fs.readFile);

export async function processInterfaceSection(attentionRootDir, filePath) {
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
