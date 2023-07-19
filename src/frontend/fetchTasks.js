import { createSignal } from 'solid-js';
import { getBaseUrl } from './getBaseUrl';

export const fetchTasks = () => {
    const [tasks, setTasks] = createSignal([]);
    const baseUrl = getBaseUrl();
    const response = fetch(`${baseUrl}/tasks`);
    response.then(r => r.json()).then(data => setTasks(data.tasks));

    return tasks;
};
