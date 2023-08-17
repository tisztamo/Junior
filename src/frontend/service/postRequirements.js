import { getBaseUrl } from '../getBaseUrl';

const postRequirements = async (requirements) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/requirements`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ requirements }),
  });

  return await response.json();
};

export default postRequirements;
