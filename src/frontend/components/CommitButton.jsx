import handleCommitService from '../service/lifecycle/handleCommitService';

const CommitButton = () => {
  return (
    <button className="w-full px-4 py-4 bg-green-500 text-lg text-bg font-semibold rounded" onClick={handleCommitService}>Commit</button>
  );
};

export default CommitButton;
