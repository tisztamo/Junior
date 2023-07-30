import { getBaseUrl } from '../getBaseUrl';
import { fetchGitStatus } from './fetchGitStatus';

const executeChange = async (change) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/execute`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ change })
  });

  const data = await response.json();

  // Fetch git status after code execution
  fetchGitStatus();

  return data;
};

export { executeChange };
