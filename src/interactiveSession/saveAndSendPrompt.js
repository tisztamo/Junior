import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import { api, rl } from '../config.js';

const saveAndSendPrompt = async (prompt, task) => {
  let lastTextLength = 0;
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg);
}

export { saveAndSendPrompt };
