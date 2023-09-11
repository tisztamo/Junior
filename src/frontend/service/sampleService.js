import { getBaseUrl } from '../getBaseUrl';

async function sampleService() { 
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/sample`);
  const text = await response.text();
  return text;
};

export default sampleService;
