import fs from 'fs';
import path from 'path';
import processItem from './processItem.js';
import getIgnoreList from './getIgnoreList.js';

async function readFileList(dir, relativePath = "") {
  const { nameIgnore, pathIgnore } = getIgnoreList();
  try {
    const items = await fs.promises.readdir(dir);
    const itemDetails = await Promise.all(
      items.map(item => processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore))
    );

    if (!relativePath) {
      return {
        type: "dir",
        name: ".",
        children: itemDetails.filter(Boolean)
      };
    } else {
      return itemDetails.filter(Boolean);
    }
  } catch (error) {
    if (error.code === 'ENOENT') {
      if (!relativePath) {
        return {
          type: "dir",
          name: ".",
          children: []
        };
      }
      throw error;
    }
    throw error;
  }
}

export default readFileList;
