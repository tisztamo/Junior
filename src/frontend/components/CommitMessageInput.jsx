import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';
import handleCommitService from '../service/lifecycle/handleCommitService';

const CommitMessageInput = () => {
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  const handleKeyPress = (e) => {
    if(e.key === 'Enter') {
      handleCommitService();
    }
  }

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} onKeyPress={handleKeyPress} />
  );
};

export default CommitMessageInput;
