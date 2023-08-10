import { getBaseUrl } from './getBaseUrl';

const generatePrompt = async (notes) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/generate`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes, systemPrompt: true })
  });

  const data = await response.json();

  if (response.status >= 400) {
    throw new Error(data.error);
  }

  return data;
};

export { generatePrompt };
