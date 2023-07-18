import { createSignal, onCleanup, onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { parseYamlAndGetTask } from '../service/parseYamlAndGetTask';
import { useWebsocket } from '../service/useWebsocket';

const TasksList = () => {
  const tasks = fetchTasks();
  const [promptDescriptor, setPromptDescriptor] = createSignal('');
  const [selectedTask, setSelectedTask] = createSignal('');

  onMount(async () => {
    const text = await fetchDescriptor();
    const task = parseYamlAndGetTask(text);
    setPromptDescriptor(text);
    setSelectedTask(task);
  });

  useWebsocket('ws://localhost:3000', async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div>
      <label>Task:</label>
      <select value={selectedTask()} onChange={e => handleTaskChange(e, setPromptDescriptor)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
      <pre>{promptDescriptor()}</pre>
    </div>
  );
};

export default TasksList;
