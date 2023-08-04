import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <CommitButton />
      <RollbackButton />
    </>
  );
};

export default ChangeFinalization;
