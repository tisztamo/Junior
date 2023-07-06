import { createSignal } from 'solid-js';

const NotesInput = () => {
  const [notes, setNotes] = createSignal('');
  
  return (
    <input type="text" value={notes()} onInput={e => setNotes(e.target.value)} />
  );
};

export default NotesInput;
