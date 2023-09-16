import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;

  // Split the path to get filename and base directory
  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px overflow-x-auto">{index + ' ' + working_dir}</span>
      <span class="flex-grow w-60% overflow-x-auto">{fileName}</span>
      <span class="flex-shrink overflow-x-auto">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
