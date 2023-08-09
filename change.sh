#!/bin/sh
set -e
goal="Implement systemPrompt feature in prompt generation"
echo "Plan:"
echo "1. Modify generateHandler.js to forward systemPrompt from request."
echo "2. Modify processPrompt.js to take a second argument forceSystemPrompt."
echo "3. Modify getSystemPromptIfNeeded.js to accept a force argument."
echo "4. Modify createPrompt.js to forward forceSystemPrompt value."
echo "5. Modify generatePrompt.js on the frontend to send systemPrompt: true with the request."

echo "\nStep 1: Modifying generateHandler.js"
cat > src/backend/handlers/generateHandler.js << 'EOF'
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  const { notes, systemPrompt } = req.body;
  const { prompt } = await processPrompt(notes, systemPrompt);
  res.json({ prompt: prompt });
};
EOF

echo "Step 2: Modifying processPrompt.js"
cat > src/prompt/processPrompt.js << 'EOF'
import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const processPrompt = async (task, forceSystemPrompt = false, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(task, forceSystemPrompt);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default processPrompt;
EOF

echo "Step 3: Modifying getSystemPromptIfNeeded.js"
cat > src/prompt/getSystemPromptIfNeeded.js << 'EOF'
import { getSystemPrompt } from "./getSystemPrompt.js";

async function getSystemPromptIfNeeded(force = false) {
  if (force || process.argv.includes("--system-prompt") || process.argv.includes("-s")) {
    return `${await getSystemPrompt()}\n`;
  }
  return "";
}

export { getSystemPromptIfNeeded };
EOF

echo "Step 4: Modifying createPrompt.js"
cat > src/prompt/createPrompt.js << 'EOF'
import { readAttention } from "../attention/readAttention.js"
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';
import promptDescriptorDefaults from './promptDescriptorDefaults.js';

const createPrompt = async (userInput, forceSystemPrompt) => {
  let promptDescriptor = yaml.load(await loadPromptDescriptor());
  let promptDescriptorDefaultsData = await promptDescriptorDefaults();

  promptDescriptor = { ...promptDescriptorDefaultsData, ...promptDescriptor };

  let templateVars = extractTemplateVars(promptDescriptor);
  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);

  const format = await loadFormatTemplate(promptDescriptor.format, templateVars);
  const system = await getSystemPromptIfNeeded(forceSystemPrompt);
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };
EOF

echo "Step 5: Modifying generatePrompt.js on the frontend"
cat > src/frontend/generatePrompt.js << 'EOF'
import { getBaseUrl } from './getBaseUrl';

const generatePrompt = async (notes) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/generate`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes, systemPrompt: true })
  });

  const data = await response.json();

  return data;
};

export { generatePrompt };
EOF

echo "\033[32mDone: $goal\033[0m\n"
