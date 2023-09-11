import { getBaseUrl } from '../getBaseUrl';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();

  // Wrap the returned array inside a root object
  if (Array.isArray(data)) {
    return {
      type: "dir",
      name: ".",
      children: data
    };
  }

  return data;
}

export default fetchFileList;
