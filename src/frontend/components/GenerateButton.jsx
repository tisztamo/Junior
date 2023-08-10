import handleGeneratePrompt from '../service/handleGeneratePrompt';

const GenerateButton = () => {
  return (
    <button className="w-full px-4 py-4 bg-blue-500 text-bg text-lg rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt [G]</button>
  );
};

export default GenerateButton;
