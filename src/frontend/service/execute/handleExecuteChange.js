import { convertLineEndings } from './convertLineEndings';
import executeChange from '../executeChange';
import { setExecutionResult } from '../../model/executionResult';
import { setChange } from '../../model/change';
import { changeInput } from '../../model/changeInput';
import { fetchGitStatus } from '../fetchGitStatus';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  let change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  change = convertLineEndings(change);
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);
  fetchGitStatus();
};

export default handleExecuteChange;
