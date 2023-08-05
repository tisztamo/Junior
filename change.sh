#!/bin/sh
set -e
goal="Reduce vertical space between input and buttons"
echo "Plan:"
echo "1. Remove the 'mt-2' class from the RollbackButton component to reduce the vertical space."
echo "2. Change the 'mt-2' margin class in the container div in ChangeFinalization component to a smaller value like 'mt-1' to reduce the space between the input and the buttons."

# Step 1: Update RollbackButton.jsx
cat > src/frontend/components/RollbackButton.jsx << 'EOF'
import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button className="w-full px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Roll Back</button>
  );
};

export default RollbackButton;

EOF

# Step 2: Update ChangeFinalization.jsx
cat > src/frontend/components/ChangeFinalization.jsx << 'EOF'
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <div className="flex w-full mt-1 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;

EOF

echo "\033[32mDone: $goal\033[0m\n"
