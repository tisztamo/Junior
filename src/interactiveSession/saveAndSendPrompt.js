import { getApi, rl } from '../config.js';
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';

const saveAndSendPrompt = async (prompt, task) => {
  let lastTextLength = 0;
  const api = await getApi();
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg);
}

export { saveAndSendPrompt };
