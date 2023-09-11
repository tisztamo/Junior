import { getBaseUrl } from '../getBaseUrl';

export const handleAttentionChange = async (attention) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ attention })
  });

  return response.ok;
};
