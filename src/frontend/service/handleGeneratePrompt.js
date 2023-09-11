import { generatePrompt } from './generatePrompt';
import { marked } from 'marked';
import { setPrompt } from '../model/prompt';
import postDescriptor from './postDescriptor';
import { requirements } from '../model/requirements';
import copyToClipboard from './copyToClipboard';

const handleGeneratePrompt = async () => {
  try {
    await postDescriptor({ requirements: requirements() });

    const response = await generatePrompt();

    await copyToClipboard(response.prompt);

    const htmlPrompt = marked(response.prompt);
    setPrompt(htmlPrompt);
  } catch (error) {
    alert(error.message);
  }
};

export default handleGeneratePrompt;
