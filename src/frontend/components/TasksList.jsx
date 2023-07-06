import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  
  const handleTaskChange = async (e) => {
    const selectedTask = e.target.value;

    const response = await fetch('http://localhost:3000/updatetask', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ task: selectedTask })
    });

    if (response.ok) {
      // Fetch the updated descriptor
      const response = await fetch('http://localhost:3000/descriptor');
      const text = await response.text();
      setPromptDescriptor(text);
    }
  };

  onMount(async () => {
    const response = await fetch('http://localhost:3000/descriptor');
    const text = await response.text();
    setPromptDescriptor(text);
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div>
      <label>Tasks:</label>
      <select onChange={handleTaskChange}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default TasksList;
