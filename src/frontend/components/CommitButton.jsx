import { postCommit } from '../service/postCommit';
import CommitMessageInput from './CommitMessageInput';
import { commitMessage } from '../stores/commitMessage';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
  };

  return (
    <div>
      <CommitMessageInput />
      <button class="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
    </div>
  );
};

export default CommitButton;
