#!/bin/sh
set -e
goal="Implement unselect feature for attention multiselect"
echo "Plan:"
echo "1. Create a function that handles the unselect feature in the ResultSet component."
echo "2. Implement the fade-out effect using Tailwind."
echo "3. Modify the ResultSet component to use this function when an item is clicked."

# 1. Create a function to handle the unselect feature.

cat << 'EOF' > src/frontend/components/MultiSelect/handleUnselectItem.jsx
import { createEffect } from 'solid-js';

const handleUnselectItem = (item, setSelectedItems, selectedItems) => {
  createEffect(() => {
    // Fade-out effect
    const element = document.querySelector(`.item-${item}`);
    if (element) {
      element.classList.add('opacity-0');
      setTimeout(() => {
        const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
        setSelectedItems(updatedItems);
      }, 300); // 300ms is the default duration for Tailwind's fast transition
    }
  });
};

export default handleUnselectItem;
EOF

# 2. Implement the fade-out effect using Tailwind by adding the necessary class.

cat << 'EOF' > src/frontend/components/MultiSelect/ListItem.jsx
import { createEffect } from "solid-js";

const ListItem = (props) => {
  let pathRef;

  const handleClick = () => {
    if (typeof props.onItemClick === 'function') {
      props.onItemClick(props.item);
    }
  };

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  // Split the path into filename and directory
  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div onClick={handleClick} class={`flex justify-between items-center w-full font-mono cursor-pointer transition-fast item-${props.item}`}>
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;
EOF

# 3. Modify the ResultSet component to use the new function when an item is clicked.

cat << 'EOF' > src/frontend/components/MultiSelect/ResultSet.jsx
import ListItem from "./ListItem";
import handleUnselectItem from "./handleUnselectItem";

const ResultSet = (props) => {
  const handleItemClick = (item) => {
    handleUnselectItem(item, props.setSelectedItems, props.selectedItems);
  };

  return (
    <div>
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={handleItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;
EOF

echo "\033[32mDone: $goal\033[0m\n"