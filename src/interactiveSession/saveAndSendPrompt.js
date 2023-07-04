import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import processPrompt from '../prompt/promptProcessing.js';

const saveAndSendPrompt = async (task, last_command_result, api, rl, startInteractiveSession) => {
  let { prompt, parent_message_id } = await processPrompt(task, last_command_result);
  let lastTextLength = 0;
  console.log("\x1b[2m");
  console.debug("Query:", prompt);
  const res = await api.sendMessage(prompt, { parentMessageId: parent_message_id, onProgress: printNewText(lastTextLength) });
  parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };
