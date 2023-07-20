import { onMount } from 'solid-js';
import { fetchTasks } from '../fetchTasks';
import { handleTaskChange } from '../service/handleTaskChange';
import { selectedTask, setSelectedTask } from '../stores/selectedTask';

const TasksList = () => {
  const tasks = fetchTasks();

  onMount(async () => {
    const task = tasks[0]; // Set default task to the first in the list
    setSelectedTask(task);
  });

  return (
    <div>
      <label>Task:</label>
      <select value={selectedTask()} onChange={e => handleTaskChange(e)}>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
