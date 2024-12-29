#!/bin/sh
set -e
goal="Add select-none class for long tap functionality"
echo "Plan:"
echo "1. Modify FilteredList.jsx to include 'select-none' class."
echo "2. Modify ResultSet.jsx to include 'select-none' class."

# Modify FilteredList.jsx to include 'select-none' class.
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
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={handleLongTap} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
EOF

# Modify ResultSet.jsx to include 'select-none' class.
cat > ./src/frontend/components/MultiSelect/ResultSet.jsx << 'EOF'
import ListItem from "./ListItem";

const ResultSet = (props) => {
  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} />)}
        </ul>
      )}
    </div>
  );
};

export default ResultSet;
EOF

echo "\033[32mDone: $goal\033[0m\n"
