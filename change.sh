#!/bin/sh
# Goal: Reprint prompt descriptor on changes
# Plan:
# 1. We are going to use the Node.js 'fs' module's 'watchFile' function to monitor changes to the prompt descriptor file.
# 2. For this, we will create a new file "watchPromptDescriptor.js" in the "prompt" directory.
# 3. This file will export a function 'watchPromptDescriptor' which takes 'rawPrinter' as an argument, similar to 'loadPromptDescriptor'.
# 4. Inside this function, we will set up a watcher for the prompt descriptor file, and on any changes, we will invoke 'loadPromptDescriptor' to reprint the content.
# 5. To avoid filename duplication, we will create a new file "promptDescriptorConfig.js" in the "prompt" directory to store the filename.
# 6. Finally, in 'startInteractiveSession', we will invoke 'watchPromptDescriptor' to begin monitoring changes to the prompt descriptor file.

# Create promptDescriptorConfig.js to store the filename
cat > ./src/prompt/promptDescriptorConfig.js << 'EOF'
export const descriptorFileName = "prompt.yaml";
EOF

# Modify loadPromptDescriptor.js to import the filename from promptDescriptorConfig.js
sed -i '' 's#const descriptorFileName = "prompt.yaml";#import { descriptorFileName } from "./promptDescriptorConfig.js";#g' ./src/prompt/loadPromptDescriptor.js

# Create watchPromptDescriptor.js
cat > ./src/prompt/watchPromptDescriptor.js << 'EOF'
import fs from 'fs';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { descriptorFileName } from './promptDescriptorConfig.js';

const watchPromptDescriptor = (rawPrinter) => {
  fs.watchFile(descriptorFileName, async (curr, prev) => {
    if (curr.mtime !== prev.mtime) {
      await loadPromptDescriptor(rawPrinter);
    }
  });
};

export default watchPromptDescriptor;
EOF

# Modify the startInteractiveSession.js file to import and use watchPromptDescriptor function
sed -i '' 's#import { loadPromptDescriptor } from '\''../prompt/loadPromptDescriptor.js'\'';#import { loadPromptDescriptor } from '\''../prompt/loadPromptDescriptor.js'\'';\
import watchPromptDescriptor from '\''../prompt/watchPromptDescriptor.js'\'';#g' ./src/interactiveSession/startInteractiveSession.js

sed -i '' 's#await loadPromptDescriptor(console.log);#await loadPromptDescriptor(console.log);\
watchPromptDescriptor(console.log);#g' ./src/interactiveSession/startInteractiveSession.js
