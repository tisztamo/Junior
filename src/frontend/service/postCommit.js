import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message, tags) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message, tags }),
  });

  const data = await response.json();

  return data;
};

export default postCommit;
