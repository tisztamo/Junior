import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button className="w-48 px-4 py-4 bg-red-700 text-white rounded mt-2" onClick={handleReset}>Roll Back</button>
  );
};

export default RollbackButton;
