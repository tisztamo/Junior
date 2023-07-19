import { getBaseUrl } from '../getBaseUrl';

export const fetchDescriptor = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`);
  const text = await response.text();
  return text;
};
