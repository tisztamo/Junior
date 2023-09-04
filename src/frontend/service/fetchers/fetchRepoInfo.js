import { getBaseUrl } from '../../getBaseUrl';

const fetchRepoInfo = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/repoinfo`);
  const data = await response.json();
  return data;
};

export default fetchRepoInfo;
