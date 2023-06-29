import fs from 'fs/promises';
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';

const saveAndSendPrompt = async (prompt, saveto, parent_message_id, api, rl, last_command_result) => {
  let lastTextLength = 0;
  console.log("\x1b[2m");
  console.debug("Query:", prompt);
  await fs.writeFile(saveto || "current_prompt.md", prompt);
  const res = await api.sendMessage(prompt, { parentMessageId: parent_message_id, onProgress: printNewText(lastTextLength) });
  parent_message_id = res.id;
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg, last_command_result, parent_message_id, rl, api);
}

export { saveAndSendPrompt };
