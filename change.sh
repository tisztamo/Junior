#!/bin/sh
# Goal: Refactor code to not pass rl (readline interface) as argument
# Plan:
# 1. Refactor the src/config.js to export rl (readline interface)
# 2. Refactor the interactiveSession files to import rl from src/config.js instead of receiving it as argument
# 3. Refactor the execute files to import rl from src/config.js instead of receiving it as argument

# Refactor src/config.js to export rl
cat << 'CONFIG' > src/config.js
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
CONFIG

# Refactor interactiveSession files
# src/interactiveSession/startInteractiveSession.js
cat << 'STARTSESSION' > src/interactiveSession/startInteractiveSession.js
import { saveAndSendPrompt } from './saveAndSendPrompt.js';
import processPrompt from '../prompt/promptProcessing.js';
import { loadPromptDescriptor } from '../prompt/loadPromptDescriptor.js';
import { rl } from '../config.js';

const startInteractiveSession = async () => {
  await loadPromptDescriptor(console.log);
  rl.question('Notes: ', async (task) => {
    let { prompt } = await processPrompt(task);
    console.log("Your prompt: ", prompt);
    rl.question('Do you want to send this prompt? (y/n): ', async (confirmation) => {
      if (confirmation.toLowerCase() === 'y') {
        await saveAndSendPrompt(prompt, task);
      } else {
        startInteractiveSession();
      }
    });
  });
};

export { startInteractiveSession };
STARTSESSION

# src/interactiveSession/saveAndSendPrompt.js
cat << 'SAVEPROMPT' > src/interactiveSession/saveAndSendPrompt.js
import { printNewText } from './printNewText.js';
import { handleApiResponse } from './handleApiResponse.js';
import { api, rl } from '../config.js';

const saveAndSendPrompt = async (prompt, task) => {
  let lastTextLength = 0;
  const res = await api.sendMessage(prompt, { onProgress: printNewText(lastTextLength) });
  console.log("\x1b[0m");
  const msg = res.text.trim();
  console.log("");
  handleApiResponse(msg);
}

export { saveAndSendPrompt };
SAVEPROMPT

# src/interactiveSession/handleApiResponse.js
cat << 'HANDLEAPI' > src/interactiveSession/handleApiResponse.js
import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod);
  } else {
    startInteractiveSession();
  }
}

export { handleApiResponse };
HANDLEAPI

# Refactor execute files
# src/execute/executeCode.js
cat << 'EXECUTECODE' > src/execute/executeCode.js
import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code) => {
  confirmAndWriteCode(code, () => executeAndForwardOutput(code));
}

export { executeCode };
EXECUTECODE

# src/execute/executeAndForwardOutput.js
cat << 'FORWARDOUTPUT' > src/execute/executeAndForwardOutput.js
import { spawn } from 'child_process';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";
import { rl } from '../config.js';

function executeAndForwardOutput(code) {
  const child = spawn(code, { shell: true });
  let last_command_result = '';

  child.stdout.on('data', (data) => {
    console.log(`${data}`);
    last_command_result += data;
  });

  child.stderr.on('data', (data) => {
    console.error(`${data}`);
    last_command_result += data;
  });

  child.on('close', (code) => {
    if (code !== 0) {
      console.log(`child process exited with code ${code}`);
      last_command_result = "Command failed. Output:\n" + last_command_result;
    } else {
      last_command_result = "Command executed. Output:\n" + last_command_result;
    }
    startInteractiveSession()
  });
}

export { executeAndForwardOutput };
FORWARDOUTPUT

# src/execute/confirmAndWriteCode.js
cat << 'CONFIRMWRITE' > src/execute/confirmAndWriteCode.js
import { rl } from '../config.js';

function confirmAndWriteCode(code, next) {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', (answer) => {
    if (answer.toLowerCase() === 'y') {
      console.log("\x1b[33mExecuting...\x1b[0m");
      next();
    } else {
      console.log("\x1b[33mNot executing.\x1b[0m");
    }
  });
}

export { confirmAndWriteCode };
CONFIRMWRITE
