import { executeChange } from '../service/executeChange';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);

    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
