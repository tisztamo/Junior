import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message, proof) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message, proof }),
  });

  const data = await response.json();

  return data;
};

export default postCommit;
