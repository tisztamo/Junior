import { getSystemPrompt } from "./getSystemPrompt.js";

async function getSystemPromptIfNeeded(force = false) {
  if (force || process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

export { getSystemPromptIfNeeded };
