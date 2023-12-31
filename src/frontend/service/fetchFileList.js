import { getBaseUrl } from '../getBaseUrl';
import { setFileList } from '../model/fileList';
import flattenPaths from './helpers/flattenPaths';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();
  let fileList = [];

  // Handle data and update file list
  if (Array.isArray(data)) {
    // If data is an array, wrap and flatten it
    fileList = flattenPaths({
      type: "dir",
      name: ".",
      children: data
    }, '');
  } else {
    // If data is not an array, process it with flattenPaths
    fileList = flattenPaths(data, '');
  }

  // Call setFileList unconditionally with either processed or raw data
  setFileList(fileList);
}

export default fetchFileList;
