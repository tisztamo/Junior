import { getBaseUrl } from '../../getBaseUrl';

let memoizedCliArgs = null;

const cliArgs = async () => {
  if (memoizedCliArgs !== null) {
    return memoizedCliArgs;
  }

  try {
    const baseUrl = getBaseUrl();
    const response = await fetch(`${baseUrl}/config`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
    });

    if (!response.ok) {
      throw new Error('Failed to fetch CLI args');
    }

    const data = await response.json();
    memoizedCliArgs = data.cliArgs || [];

    return memoizedCliArgs;
  } catch (error) {
    console.error(`Error fetching CLI args: ${error.message}`);
    return [];
  }
};

export default cliArgs;
