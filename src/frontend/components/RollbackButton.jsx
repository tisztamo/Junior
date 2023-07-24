import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Roll Back to Last Commit</button>
  );
};

export default RollbackButton;
