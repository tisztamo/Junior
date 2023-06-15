#!/usr/bin/env node

import createQuery from './prompt/prompt.js';
import { api, get_model, get_system_prompt, rl } from './config.js';
import executeCode from './execute/executeCode.js';
import extractCode from './execute/extractCode.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await get_system_prompt())

const main = async (last_command_result = "", parent_message_id = null, rl) => {
  rl.question('$ ', async (task) => {
    let lastTextLength = 0;
    console.log("\x1b[2m");
    const query = await createQuery(task, last_command_result)
    console.debug("Query:", query)
    const res = await api.sendMessage(query, {
      parentMessageId: parent_message_id,
      onProgress: (partialResponse) => {
        // Print only the new text added to the partial response
        const newText = partialResponse.text.slice(lastTextLength);
        process.stdout.write(newText);
        lastTextLength = partialResponse.text.length;
      }
    });
    parent_message_id = res.id;
    console.log("\x1b[0m");
    const msg = res.text.trim();
    console.log("");
    const cod = extractCode(msg);
    if (cod) {
      await executeCode(cod, last_command_result, parent_message_id, rl);
    } else {
      last_command_result = "";
      main(last_command_result, parent_message_id, rl);
    }
  });
}

main("", null, rl);

export default main;
