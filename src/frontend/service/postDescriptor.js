import { getBaseUrl } from '../getBaseUrl';

const postDescriptor = async (descriptor) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(descriptor),
  });

  return await response.json();
};

export default postDescriptor;
