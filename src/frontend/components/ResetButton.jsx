import { resetGit } from '../service/resetGit';

const ResetButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button class="px-8 py-4 bg-red-300 text-white rounded" onClick={handleReset}>Reset Git</button>
  );
};

export default ResetButton;
