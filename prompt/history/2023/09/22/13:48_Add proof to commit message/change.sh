#!/bin/sh
set -e
goal="Add proof to commit message"
echo "Plan:"
echo "1. Extract the 'proof' field from the request."
echo "2. Modify commitGitHandler to append 'proof' to the commit message, if not empty."

cat > ./src/backend/handlers/git/commitGitHandler.js << 'EOF'
import commitGit from '../../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    const proof = req.body.proof;
    
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }

    let finalMessage = message;
    if (proof && proof.trim() !== "") {
      finalMessage = `${message} ${proof}`;
    }
    
    await commitGit(finalMessage);
    res.status(200).send({ message: `Successfully committed with message: ${finalMessage}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
}
EOF

echo "\033[32mDone: $goal\033[0m\n"