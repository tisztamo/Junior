import { createEffect } from 'solid-js';
import { change } from '../stores/change';
import { setCommitMessage } from '../stores/commitMessage';

let monitoring = false;

const monitorChangeSignal = () => {
  if (monitoring) return;

  monitoring = true;

  createEffect(() => {
    const newChangeContent = change();
    const goalLineMatch = newChangeContent.match(/goal="(.+?)"/);
    
    if (goalLineMatch) {
      const goalValue = goalLineMatch[1];
      
      setCommitMessage(goalValue);
    }
  });
};

export default monitorChangeSignal;
