import { createEffect } from 'solid-js';
import { change } from '../stores/change';
import { setCommitMessage } from '../stores/commitMessage';

const monitorChangeSignal = () => {
  createEffect(() => {
    const newChangeContent = change();
    // Check if the new content has the goal variable
    const goalLineMatch = newChangeContent.match(/goal="(.+?)"/);
    
    if (goalLineMatch) {
      const goalValue = goalLineMatch[1];
      
      // Set the commit message to the value of the goal variable
      setCommitMessage(goalValue);
    }
  });
};

export default monitorChangeSignal;
