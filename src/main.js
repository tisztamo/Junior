#!/usr/bin/env node

import fs from 'fs/promises';
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';
import { exec } from 'child_process';
import { promisify } from 'util';
import createQuery from './prompt.js';
const execAsync = promisify(exec);

const TOKEN = process.env.OPENAI_API_KEY;
const MODEL = await get_model();
const SHELL = await get_shell();

console.log("Welcome to Contributor. Model: " + MODEL + "\n");

const SYSTEM = (await fs.readFile("prompt/system.md", "utf8")).toString()

console.log("System prompt:", SYSTEM)

// initialize ChatGPT API with your API key
const api = process.argv[2] === "-d" ? {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  } : new ChatGPTAPI({
  debug: true,
  apiKey: TOKEN,
  //systemMessage: SYSTEM,
  completionParams: {
    model: MODEL,
    stream: true,
    temperature: 0.5,
    max_tokens: 2048,
  }
});

// create readline interface for user input
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Yes most of this was written by GPT, how do you know?
async function main(last_command_result = "", parent_message_id = null) {
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
    const cod = extract_code(msg);
    if (cod) {
      rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', async (answer) => {
        console.log("");
        if (answer.toLowerCase() === 'y' || answer === "") {
          exec(cod, (error, stdout, stderr) => {
            if (error) {
              console.error(`${error.message}`);
              last_command_result = "Command failed. Output:\n" + error.message + "\n";
            } else {
              if (stdout.length > 0) {
                console.log(`${stdout}`);
              }
              if (stderr.length > 0) {
                console.log(`${stderr}`);
              }
              last_command_result = "Command executed. Output:\n" + stdout + "\n" + stderr + "\n";
            }
            main(last_command_result, parent_message_id);
          });
        } else {
          last_command_result = "Command skipped.\n";
          main(last_command_result, parent_message_id);
        }
      });
    } else {
      last_command_result = "";
      main(last_command_result, parent_message_id);
    }
  });
}

function extract_code(res) {
  const match = res.match(/```sh([\s\S]*?)```/);
  return match ? match[1].trim() : null;
}

async function is_installed(cmd) {
  try {
    await execAsync('command -v '+cmd);
    return true;
  } catch (err) {
    return false;
  }
}

async function get_model() {
  return process.argv[2] === "4" ? "gpt-4" : "gpt-3.5-turbo";
}

async function get_shell() {
  const shellInfo = (await execAsync('uname -a && $SHELL --version')).stdout.trim();
  return shellInfo;
}

async function get_root_info() {
  const rootInfo = (await execAsync('ls')).stdout.trim();
}

main();
