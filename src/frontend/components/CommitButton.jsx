import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../stores/executionResult';
import { setPrompt } from '../stores/prompt';
import { setChange } from '../stores/change'; // Importing setChange to clear the change

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setChange(''); // Clearing the change after commit
    setExecutionResult('');
    setCommitMessage('');
    setPrompt('');
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
