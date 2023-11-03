#!/bin/sh
set -e
goal="Refactor by renaming handleLongTap to handleFilePopup"
echo "Plan:"
echo "1. Rename handleLongTap.jsx to handleFilePopup.jsx"
echo "2. Update handleLongTap function to handleFilePopup"
echo "3. Update imports in ResultSet.jsx and FilteredList.jsx"
echo "4. Replace contents of ResultSet.jsx and FilteredList.jsx with updated code"

# Rename handleLongTap.jsx to handleFilePopup.jsx
mv ./src/frontend/components/MultiSelect/handleLongTap.jsx ./src/frontend/components/MultiSelect/handleFilePopup.jsx

# Update handleLongTap function to handleFilePopup in handleFilePopup.jsx
cat > ./src/frontend/components/MultiSelect/handleFilePopup.jsx << 'EOF'
import { createSignal } from 'solid-js';

const handleFilePopup = () => {
  const [showPopup, setShowPopup] = createSignal(false);
  const [popupPath, setPopupPath] = createSignal('');

  const invoke = (path) => {
    setPopupPath(path);
    setShowPopup(true);
  };

  return { showPopup, setShowPopup, popupPath, invoke };
};

export default handleFilePopup;
EOF

# Update imports and references in ResultSet.jsx
cat > ./src/frontend/components/MultiSelect/ResultSet.jsx << 'EOF'
import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
import handleFilePopup from './handleFilePopup';

const ResultSet = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleFilePopup();

  return (
    <div class="select-none">
      {props.items.length === 0 ? (
        <div class="text-gray-400 pl-2">{props.emptyMessage}</div>
      ) : (
        <ul class="list-inside select-none">
          {props.items.map(item => <ListItem key={item} item={item} onItemClick={props.onItemClick} onLongTap={invoke} />)}
        </ul>
      )}
      { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default ResultSet;
EOF

# Update imports and references in FilteredList.jsx
cat > ./src/frontend/components/MultiSelect/FilteredList.jsx << 'EOF'
import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
import handleFilePopup from './handleFilePopup';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleFilePopup();

  return (
    <div class="select-none">
      <ul class="list-inside select-none">
        {props.items.map((item, idx) => <ListItem key={item} item={item} idx={idx + 1} onItemClick={props.onItemClick} onLongTap={invoke} />)}
      </ul>
      { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"