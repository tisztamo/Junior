import CommitMessageInput from './CommitMessageInput';
import ProofInput from './ProofInput';
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
          <ProofInput />
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

