import handleGeneratePrompt from '../service/handleGeneratePrompt';

const GenerateButton = () => {
  return (
    <button className="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt [G]</button>
  );
};

export default GenerateButton;
