import processPrompt from '../prompt/promptProcessing.js';
import { saveAndSendPrompt } from './saveAndSendPrompt.js';

const startInteractiveSession = async (last_command_result = "", parent_message_id = null, rl, api) => {
  rl.question('$ ', async (task) => {
    const { prompt, parent_message_id: newParentMessageId } = await processPrompt(task, last_command_result);
    await saveAndSendPrompt(prompt, newParentMessageId, api, rl, last_command_result, startInteractiveSession);
  });
};

export { startInteractiveSession };
