import { fetchTasks } from '../fetchTasks';

const TasksList = () => {
  const tasks = fetchTasks();

  return (
    <div>
      <label>Tasks:</label>
      <select>
        {tasks().map(task => <option value={task}>{task}</option>)}
      </select>
    </div>
  );
};

export default TasksList;
