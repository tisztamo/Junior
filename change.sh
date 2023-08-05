#!/bin/sh
set -e
goal="Change layout of commit and rollback buttons"
echo "Plan:"
echo "1. Modify ChangeFinalization.jsx to arrange CommitButton and RollbackButton horizontally using Tailwind CSS."

cat > src/frontend/components/ChangeFinalization.jsx << 'EOF'
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <div className="flex justify-between mt-2">
        <CommitButton />
        <RollbackButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
EOF

echo "\033[32mDone: $goal\033[0m\n"
