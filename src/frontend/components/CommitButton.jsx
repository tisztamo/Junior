import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../stores/executionResult'; // Importing the necessary function to clear execution result
import { setPrompt } from '../stores/prompt'; // Importing setPrompt to clear the prompt

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setExecutionResult(''); // Clearing the execution result after commit
    setCommitMessage(''); // Clearing the commit message after commit
    setPrompt(''); // Clearing the prompt after commit
  };

  return (
    <button className="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;
