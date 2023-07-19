import { getBaseUrl } from '../getBaseUrl';
import { fetchDescriptor } from './fetchDescriptor';

export const handleTaskChange = async (e, setPromptDescriptor) => {
  const baseUrl = getBaseUrl();
  const selectedTask = e.target.value;

  const response = await fetch(`${baseUrl}/updatetask`, {
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
