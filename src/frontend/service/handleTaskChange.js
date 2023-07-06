import { fetchDescriptor } from './fetchDescriptor';

export const handleTaskChange = async (e, setPromptDescriptor) => {
  const selectedTask = e.target.value;

  const response = await fetch('http://localhost:3000/updatetask', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ task: selectedTask })
  });

  if (response.ok) {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  }
};
