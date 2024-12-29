#!/bin/sh
set -e
goal="Rename proof to tags and ProofInput to TagsInput"
echo "Plan:"
echo "1. Rename 'proof' to 'tags' in all the files."
echo "2. Rename 'ProofInput' to 'TagsInput' in all the files."
echo "3. Update imports accordingly."
echo "4. Remove old files if any were renamed."

# Step 1: Rename 'proof' to 'tags' in all the files.
cat > ./src/frontend/model/tagsModel.js << 'EOF'
import { createSignal } from 'solid-js';

const [tags, setTags] = createSignal('');

export { tags, setTags };
EOF

cat > ./src/frontend/components/TagsInput.jsx << 'EOF'
import { createSignal } from 'solid-js';
import { tags, setTags } from '../model/tagsModel';

const TagsInput = () => {
  const handleChange = (e) => {
    setTags(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Tags..." value={tags()} onInput={handleChange} />
  );
};

export default TagsInput;
EOF

cat > ./src/backend/handlers/git/commitGitHandler.js << 'EOF'
import commitGit from '../../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    const tags = req.body.tags;
    
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }

    let finalMessage = message;
    if (tags && tags.trim() !== "") {
      finalMessage = `${message} ${tags}`;
    }
    
    await commitGit(finalMessage);
    res.status(200).send({ message: `Successfully committed with message: ${finalMessage}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
}
EOF

cat > ./src/frontend/service/clearState.js << 'EOF'
import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';
import { setGitStatus } from '../model/gitStatus';
import { setTags } from '../model/tagsModel';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
  setGitStatus('');
  setTags('');
};

export default clearState;
EOF

cat > ./src/frontend/components/ChangeFinalization.jsx << 'EOF'
import CommitMessageInput from './CommitMessageInput';
import TagsInput from './TagsInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <div className="flex w-full space-x-4">
        <div className="flex-grow w-3/4">
          <CommitMessageInput />
        </div>
        <div className="w-1/4">
          <TagsInput />
        </div>
      </div>
      <div className="flex w-full mt-1 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
EOF

cat > ./src/frontend/service/lifecycle/handleCommitService.js << 'EOF'
import postCommit from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { tags } from '../../model/tagsModel';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage(), tags());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);
  clearState();
}
EOF

cat > ./src/frontend/service/postCommit.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message, tags) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message, tags }),
  });

  const data = await response.json();

  return data;
};

export default postCommit;
EOF

# Step 4: Remove old files if any were renamed.
rm -f ./src/frontend/model/proofModel.js
rm -f ./src/frontend/components/ProofInput.jsx

echo "\033[32mDone: $goal\033[0m\n"