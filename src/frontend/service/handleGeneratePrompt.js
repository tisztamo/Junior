import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';

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

export default handleGeneratePrompt;
