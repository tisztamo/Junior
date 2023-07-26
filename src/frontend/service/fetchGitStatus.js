import { getBaseUrl } from '../getBaseUrl';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/status`);

  const data = await response.json();

  return data;
};

export { fetchGitStatus };
