import handleExecuteChange from '../service/handleExecuteChange';
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const keyBindings = () => {
  return {
    'G': (e) => {
      handleGeneratePrompt();
    },
    'X': (e) => {
      handleExecuteChange();
    }
  };
};

export default keyBindings;
