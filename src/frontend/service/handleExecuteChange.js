import { executeChange } from './executeChange';
import { setExecutionResult } from '../model/executionResult';
import { setChange } from '../model/change';
import { changeInput } from '../model/changeInput';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);
};

export default handleExecuteChange;
