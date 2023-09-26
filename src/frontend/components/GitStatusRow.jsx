import { createEffect } from "solid-js";
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const { onClick } = props;

  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);

  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`} onClick={() => onClick(path)}>
      <span class="w-50px overflow-x-auto p-1">{index + ' ' + working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
