import { executeChange } from '../service/executeChange';
import { setExecutionResult } from './executionResult';
import { setChange } from './change';
import { changeInput } from './changeInput';

const handleExecuteChange = async () => {
  const clipboardAvailable = !!(navigator.clipboard && navigator.clipboard.readText);
  const change = clipboardAvailable ? await navigator.clipboard.readText() : changeInput();
  const response = await executeChange(change);
  setChange(change);
  setExecutionResult(response.output);
  console.log(response.output);
};

export default handleExecuteChange;
