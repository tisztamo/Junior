import { generatePrompt } from '../generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';
import postDescriptor from '../service/postDescriptor';
import { requirements } from '../model/requirements';
import copyToClipboard from './copyToClipboard';

const handleGeneratePrompt = async () => {
  try {
    await postDescriptor({ requirements: requirements() });

    const response = await generatePrompt();

    try {
      await copyToClipboard(response.prompt);
      console.log('Prompt copied to clipboard!');
    } catch (err) {
      console.error('Failed to copy prompt: ', err);
    }

    const htmlPrompt = marked(response.prompt);
    setPrompt(htmlPrompt);
  } catch (error) {
    alert(error.message);
  }
};

export default handleGeneratePrompt;
