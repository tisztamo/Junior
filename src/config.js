import readline from 'readline';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "./prompt/getSystemPrompt.js";

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
  const modelArg = process.argv.find(arg => arg.startsWith('--model='));
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

export { api, rl, get_model };
