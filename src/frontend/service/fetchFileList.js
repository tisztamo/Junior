import { getBaseUrl } from '../getBaseUrl';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();
  return data;
};

export default fetchFileList;
