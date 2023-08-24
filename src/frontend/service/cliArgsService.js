import { getBaseUrl } from '../getBaseUrl';

const fetchCliArgs = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/config`, {
    method: 'GET',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data.cliargs || [];
};

export const isBetaEnabled = async () => {
  const cliArgs = await fetchCliArgs();
  return cliArgs.includes('--beta');
}
