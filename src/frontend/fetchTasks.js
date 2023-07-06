import { createSignal } from 'solid-js';

export const fetchTasks = () => {
    const [tasks, setTasks] = createSignal([]);

    const response = fetch('http://localhost:3000/tasks');
    response.then(r => r.json()).then(data => setTasks(data.tasks));

    return tasks;
};
