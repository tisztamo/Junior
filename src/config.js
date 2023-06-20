import fs from 'fs/promises';
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';

const api = process.argv[2] === "-d" ? {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  } : new ChatGPTAPI({
  debug: true,
  apiKey: process.env.OPENAI_API_KEY,
  systemMessage: "",//SYSTEM,
  completionParams: {
    model: get_model(),
    stream: true,
    temperature: 0.5,
    max_tokens: 2048,
  }
});

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function get_model() {
  return process.argv[2] === "4" ? "gpt-4" : "gpt-3.5-turbo";
}

async function get_system_prompt() {
  return (await fs.readFile("prompt/system.md", "utf8")).toString()
}
export { api, rl, get_model, get_system_prompt };
