import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';
import { setGitStatus } from '../model/gitStatus';
import { setTags } from '../model/tagsModel';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
  setGitStatus('');
  setTags('');
};

export default clearState;
