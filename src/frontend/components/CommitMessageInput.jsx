import { onCleanup } from 'solid-js';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import monitorChangeSignal from '../stores/monitorChange';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChangeSignal();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-64 px-4 py-2 border rounded" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
