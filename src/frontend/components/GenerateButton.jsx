import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../stores/prompt';

const GenerateButton = () => {
  const handleGeneratePrompt = async () => {
    const response = await generatePrompt();

    navigator.clipboard.writeText(response.prompt)
      .then(() => {
        console.log('Prompt copied to clipboard!');
      })
      .catch(err => {
        console.error('Failed to copy prompt: ', err);
      });

    const htmlPrompt = marked(response.prompt);

    setPrompt(htmlPrompt);
  };

  return (
    <button className="w-64 px-4 py-4 bg-blue-500 text-white rounded" onClick={handleGeneratePrompt}>Generate & Copy Prompt</button>
  );
};

export default GenerateButton;
