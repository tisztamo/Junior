#!/bin/sh
set -e
goal="Implement long tap display for source in popup"
echo "Plan:"
echo "1. Create a new module for the long tap detection."
echo "2. Create a module for the popup displaying the source."
echo "3. Integrate the long tap detection into the FilteredList items."
echo "4. When a long tap is detected, conditionally render the full screen popup with the source display."

# Create LongTapDetector module
cat > ./src/frontend/components/MultiSelect/LongTapDetector.js << 'EOF'
import { onCleanup } from 'solid-js';

const useLongTap = (callback, duration = 500) => {
  let timer;

  const startLongTapDetection = () => {
    timer = setTimeout(callback, duration);
  };

  const cancelLongTapDetection = () => {
    clearTimeout(timer);
  };

  onCleanup(() => {
    clearTimeout(timer);
  });

  return {
    onTouchStart: startLongTapDetection,
    onTouchEnd: cancelLongTapDetection,
    onMouseDown: startLongTapDetection,
    onMouseUp: cancelLongTapDetection,
    onMouseLeave: cancelLongTapDetection
  };
};

export default useLongTap;
EOF

# Create FullScreenPopup module
cat > ./src/frontend/components/MultiSelect/FullScreenPopup.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';

const FullScreenPopup = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-3/4 h-3/4 rounded-lg overflow-y-auto">
          <button class="absolute top-4 right-4" onClick={props.onClose}>Close</button>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FullScreenPopup;
EOF

# Integrate LongTapDetector and FullScreenPopup into FilteredList
cat > ./src/frontend/components/MultiSelect/FilteredList.jsx << 'EOF'
import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import { createSignal } from 'solid-js';

const FilteredList = (props) => {
  const [showPopup, setShowPopup] = createSignal(false);
  const [popupPath, setPopupPath] = createSignal('');

  const handleLongTap = (path) => {
    setPopupPath(path);
    setShowPopup(true);
  };

  return (
    <div>
      <ul class="list-inside">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={handleLongTap} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
EOF

# Update ListItem to use LongTapDetector
cat > ./src/frontend/components/MultiSelect/ListItem.jsx << 'EOF'
import { createEffect } from "solid-js";
import useLongTap from "./LongTapDetector";

const ListItem = (props) => {
  let pathRef;
  const uniqueId = `item-${Math.random().toString(36).substr(2, 9)}`;
  const longTapActions = useLongTap(() => props.onLongTap(props.item));

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

  const [filename, ...pathParts] = props.item.split('/').reverse();
  const directory = pathParts.reverse().join('/');

  return (
    <div id={uniqueId} onClick={handleClick} {...longTapActions} class="flex justify-between items-center w-full font-mono cursor-pointer">
      <span class="text-base bg-main rounded p-1">{filename}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{directory}</span>
    </div>
  );
};

export default ListItem;
EOF

echo "\033[32mDone: $goal\033[0m\n"