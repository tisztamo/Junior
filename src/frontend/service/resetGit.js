import { getBaseUrl } from '../getBaseUrl';

const resetGit = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data;
};

export { resetGit };
