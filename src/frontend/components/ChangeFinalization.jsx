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
