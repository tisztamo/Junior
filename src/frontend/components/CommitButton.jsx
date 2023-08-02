import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
  };

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <div>
      <input type="text" class="w-64 px-4 py-2 border rounded" placeholder="Commit message..." onInput={handleChange} />
      <button class="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
    </div>
  );
};

export default CommitButton;
