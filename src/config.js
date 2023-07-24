import readline from 'readline';
import createApi from './llm/openai/createApi.js';

function isDryRun() {
  return process.argv.includes("-d") || process.argv.includes("--dry-run");
}

function get_model() {
  const modelArg = process.argv.find(arg => arg.startsWith('--model='));
  if (modelArg) {
    return modelArg.split('=')[1];
  }
  return "gpt-4";
}

async function getApi() {
  if (isDryRun()) {
    return {
      sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
    };
  } else {
    return await createApi(get_model());
  }
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

export { getApi, rl, get_model };
