import { getBaseUrl } from '../../getBaseUrl';

const cliArgs = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/config`, {
    method: 'GET',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data.cliargs || [];
};

export default cliArgs;
