#!/bin/sh
set -e
goal="Refactor FullScreenPopup to FileViewer and move it"
echo "Plan:"
echo "1. Rename FullScreenPopup.jsx to FileViewer.jsx"
echo "2. Update FileViewer.jsx content"
echo "3. Update imports in ResultSet.jsx and FilteredList.jsx"
echo "4. Move FileViewer.jsx to components/files directory"

# 1. Rename FullScreenPopup.jsx to FileViewer.jsx
mv ./src/frontend/components/MultiSelect/FullScreenPopup.jsx ./src/frontend/components/MultiSelect/FileViewer.jsx

# 2. Update FileViewer.jsx content
cat > ./src/frontend/components/MultiSelect/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto">
          <div class="absolute top-4 right-4" onClick={props.onClose}></div>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
EOF

# 3. Update imports in ResultSet.jsx and FilteredList.jsx
cat > ./src/frontend/components/MultiSelect/ResultSet.jsx << 'EOF'
import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
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
      { showPopup() && <FileViewer path={popupPath()} onClose={() => setShowPopup(false)} /> }
    </div>
  );
};

export default ResultSet;
EOF

cat > ./src/frontend/components/MultiSelect/FilteredList.jsx << 'EOF'
import ListItem from "./ListItem";
import FileViewer from "../files/FileViewer";
import handleLongTap from './handleLongTap';

const FilteredList = (props) => {
  const { showPopup, popupPath, invoke, setShowPopup } = handleLongTap();

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

# 4. Move FileViewer.jsx to components/files directory
mv ./src/frontend/components/MultiSelect/FileViewer.jsx ./src/frontend/components/files/FileViewer.jsx

echo "\033[32mDone: $goal\033[0m\n"