import { getBaseUrl } from '../getBaseUrl';
import { setGitStatus } from '../model/gitStatus';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/status`);

  const data = await response.json();

  setGitStatus(data);
};

export default fetchGitStatus;
