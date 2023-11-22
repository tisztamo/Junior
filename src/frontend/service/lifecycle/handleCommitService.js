import postCommit from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { tags } from '../../model/tagsModel';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';
import fetchFileList from '../fetchFileList';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage(), tags());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);

  // Refresh file list
  await fetchFileList();

  clearState();
}
