import { createEffect } from "solid-js";

const ListItem = (props) => {
  let pathRef;
  const uniqueId = `item-${Math.random().toString(36).substr(2, 9)}`;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item, uniqueId);
    }
  };

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div id={uniqueId} onClick={handleClick} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;