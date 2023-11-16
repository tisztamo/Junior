import { getBaseUrl } from '../getBaseUrl';

export const handleAttentionChange = async (attention, setAttention) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ attention })
  });

  if (response.ok) {
    setAttention(attention);
  }

  return response.ok;
};
