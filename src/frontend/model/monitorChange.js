import { createEffect } from 'solid-js';
import { change } from '../model/change';
import { setCommitMessage } from '../model/commitMessage';

// The monitorChange function starts monitoring the change store,
// and if a goal is found, it sets the commit message accordingly.
let monitoring = false;

const monitorChange = () => {
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

export default monitorChange;
