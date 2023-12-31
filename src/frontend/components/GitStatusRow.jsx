import { createEffect } from "solid-js";
import getStyleForFileStatus from './getStyleForFileStatus';

const GitStatusRow = (props) => {
  const { path, working_dir } = props.entry;
  const { onClick } = props;

  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const textStyle = getStyleForFileStatus(working_dir, path);

  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  return (
    <div class="flex" style={textStyle} onClick={() => onClick(path)}>
      <span class="w-50px overflow-x-auto p-1">{working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
