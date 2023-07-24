#!/bin/sh
set -e
goal="Refactor dry-run API creation"
echo "Plan:"
echo "1. Create a new file 'createFakeApi.js' inside './src/llm/fake/'"
echo "2. Copy the code related to fake api creation from 'config.js' to 'createFakeApi.js'"
echo "3. Modify 'config.js' to import and use the 'createFakeApi.js' function"
echo "4. Modify 'openai/createApi.js' to warn and return a fake api instance when OPENAI_API_KEY not found"

mkdir -p ./src/llm/fake/

cat << 'EOF' > ./src/llm/fake/createFakeApi.js
export default function createFakeApi() {
  return {
    sendMessage: () => { return {id: 42, text: "DRY RUN, NOT SENT"}}
  };
}
EOF

cat << 'EOF' > ./src/config.js
import readline from 'readline';
import createApi from './llm/openai/createApi.js';
import createFakeApi from './llm/fake/createFakeApi.js';

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
    return createFakeApi();
  } else {
    return await createApi(get_model());
  }
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

export { getApi, rl, get_model };
EOF

cat << 'EOF' > ./src/llm/openai/createApi.js
import fs from 'fs';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "../../prompt/getSystemPrompt.js";
import createFakeApi from '../fake/createFakeApi.js';

export default async function createApi(model) {
  let apiKey = process.env.OPENAI_API_KEY;

  if (!apiKey) {
    if (fs.existsSync('./secret.sh')) {
      const secretFileContent = fs.readFileSync('./secret.sh', 'utf-8');
      const match = secretFileContent.match(/export OPENAI_API_KEY=(\S+)/);
      if (match) {
        apiKey = match[1];
      }
    }
  }

  if (!apiKey) {
    console.warn('OPENAI_API_KEY not found, using fake API');
    return createFakeApi();
  }

  const systemMessage = await getSystemPrompt();

  return new ChatGPTAPI({
    debug: true,
    apiKey,
    systemMessage,
    completionParams: {
      model,
      stream: true,
      temperature: 0.5,
      max_tokens: 2048,
    }
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
