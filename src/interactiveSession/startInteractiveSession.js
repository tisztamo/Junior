import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/promptProcessing.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task, last_command_result);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task, last_command_result, api, rl, startInteractiveSession);
      } else {
        startInteractiveSession(last_command_result, parent_message_id, rl, api);
      }
    });
  });
};

export { startInteractiveSession };
