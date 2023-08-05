#!/bin/sh
set -e
goal="Switch the two buttons in ChangeFinalization"
echo "Plan:"
echo "1. Update the ChangeFinalization.jsx file to switch the positions of the CommitButton and RollbackButton components."

cat > src/frontend/components/ChangeFinalization.jsx << 'EOF'
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <div className="flex w-full mt-2 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
EOF

echo "\033[32mDone: $goal\033[0m\n"
