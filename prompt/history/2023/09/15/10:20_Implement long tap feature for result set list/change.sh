#!/bin/sh
set -e
goal="Implement long tap feature for result set list"
echo "Plan:"
echo "1. Extract the handleLongTap functionality from FilteredList.jsx to a new file for reuse."
echo "2. Modify ResultSet.jsx to integrate the long tap functionality."
echo "3. Modify FilteredList.jsx to use the newly extracted long tap functionality."
echo "4. No changes to AttentionFileList.jsx as it uses ResultSet which has already been updated."

# Extract the long tap functionality into a separate file
cat > ./src/frontend/components/MultiSelect/handleLongTap.jsx << 'EOF'
import { createSignal } from 'solid-js';

const handleLongTap = () => {
  const [showPopup, setShowPopup] = createSignal(false);
  const [popupPath, setPopupPath] = createSignal('');

  const invoke = (path) => {
    setPopupPath(path);
    setShowPopup(true);
  };

  return { showPopup, setShowPopup, popupPath, invoke };
};

export default handleLongTap;
EOF

# Modify ResultSet.jsx to use the new long tap functionality
cat > ./src/frontend/components/MultiSelect/ResultSet.jsx << 'EOF'
import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import handleLongTap from './handleLongTap';

const ResultSet = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} onLongTap={invoke} />)}
        </ul>
      )}
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default ResultSet;
EOF

# Modify FilteredList.jsx to use the newly extracted long tap functionality
cat > ./src/frontend/components/MultiSelect/FilteredList.jsx << 'EOF'
import ListItem from "./ListItem";
import FullScreenPopup from "./FullScreenPopup";
import handleLongTap from './handleLongTap';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={invoke} />)}
      </ul>
      { showPopup() && <FullScreenPopup path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
EOF

# No changes to AttentionFileList.jsx as it uses ResultSet which has already been updated.

echo "\033[32mDone: $goal\033[0m\n"