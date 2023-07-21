import { executeChange } from '../service/executeChange';

const ExecuteButton = () => {
  const handleExecuteChange = async () => {
    const change = await navigator.clipboard.readText();
    const response = await executeChange(change);

    console.log(response.message);
  };

  return (
    // Updated button color to a less flashy orange
    <button class="px-8 py-4 bg-orange-300 text-white rounded" onClick={handleExecuteChange}>Paste & Execute Change</button>
  );
};

export default ExecuteButton;
