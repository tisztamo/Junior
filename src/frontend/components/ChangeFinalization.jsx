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
