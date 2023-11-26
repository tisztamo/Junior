import { getBaseUrl } from '../getBaseUrl';

export const fetchPromptsToTry = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/promptstotry`);
  if (!response.ok) {
    throw new Error('Failed to fetch prompts to try');
  }
  return await response.json();
};
