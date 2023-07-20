import { getBaseUrl } from '../getBaseUrl';
import { fetchDescriptor } from './fetchDescriptor';
import { setPromptDescriptor } from '../stores/promptDescriptor';

export const handleTaskChange = async (e) => {
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
