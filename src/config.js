import fs from 'fs/promises';
import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';

// test if -d or --dry-run cli arg is present
function isDryRun() {
  return process.argv.includes("-d") || process.argv.includes("--dry-run");
}

const api = isDryRun() ? {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  } : new ChatGPTAPI({
  debug: true,
  apiKey: process.env.OPENAI_API_KEY,
  systemMessage: await getSystemPrompt(),
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

async function getSystemPrompt() {
  return (await fs.readFile("prompt/system.md", "utf8")).toString()
}
export { api, rl, get_model, getSystemPrompt};
