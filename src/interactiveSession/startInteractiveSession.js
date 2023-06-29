import { createPrompt } from '../prompt/createPrompt.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, saveto } = await createPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, saveto, parent_message_id, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };
