import { getBaseUrl } from '../getBaseUrl';

const executeChange = async (change) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/execute`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ change })
  });

  const data = await response.json();

  return data;
};

export { executeChange };
