import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
};

export default clearState;
