import CommitMessageInput from './CommitMessageInput';
import ProofInput from './ProofInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <div className="flex w-full space-x-4">
        <CommitMessageInput className="flex-grow w-7/10" />
        <ProofInput className="w-3/10" />
      </div>
      <div className="flex w-full mt-1 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
