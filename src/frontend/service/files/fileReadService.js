import { getBaseUrl } from '../../getBaseUrl';

async function fileReadService(path) { 
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/read/${path}`);
  const text = await response.text();
  return text;
};

export default fileReadService;
