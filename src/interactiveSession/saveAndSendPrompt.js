import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';

const saveAndSendPrompt = async (prompt, task, last_command_result, api, rl, startInteractiveSession) => {
  let lastTextLength = 0;
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  const parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };
