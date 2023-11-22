import { getBaseUrl } from '../getBaseUrl';
import { setFileList } from '../model/fileList';
import flattenPaths from './helpers/flattenPaths';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();

  // Handle data and update file list
  if (Array.isArray(data)) {
    const flattenedData = flattenPaths({
      type: "dir",
      name: ".",
      children: data
    }, '');
    setFileList(flattenedData);
  }
}

export default fetchFileList;
