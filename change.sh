#!/bin/sh
set -e
goal="Refactor code to handle OPENAI_API_KEY"
echo "Plan:"
echo "1. Create the directory src/llm/openai"
echo "2. Create the file src/llm/openai/createApi.js"
echo "3. Move the logic for creating the ChatGPTAPI instance to createApi.js"
echo "4. Implement the logic to read the OPENAI_API_KEY from the environment variable or from the secret.sh file"
echo "5. Update src/config.js to import and use the createApi function from createApi.js"

mkdir -p src/llm/openai

cat << 'EOF' > src/llm/openai/createApi.js
import fs from 'fs';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "../../prompt/getSystemPrompt.js";

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
    throw new Error('OPENAI_API_KEY not found');
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

cat << 'EOF' > src/config.js
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
EOF

echo "\033[32mDone: $goal\033[0m\n"
