import handleExecuteChange from '../model/handleExecuteChange';
import handleGeneratePrompt from '../service/handleGeneratePrompt';

const keyBindings = () => {
  return {
    'G': (e) => {
      handleGeneratePrompt();
      console.log('G key pressed'); // Temporary log
    },
    'X': (e) => {
      handleExecuteChange();
      console.log('X key pressed'); // Temporary log
    }
  };
};

export default keyBindings;
