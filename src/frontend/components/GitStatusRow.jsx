import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`grid grid-cols-3 ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="col-span-1 w-50px">{index}</span>
      <span class="col-span-1 w-60%">{path}</span>
      <span class="col-span-1">{working_dir}</span>
    </div>
  );
};

export default GitStatusRow;
