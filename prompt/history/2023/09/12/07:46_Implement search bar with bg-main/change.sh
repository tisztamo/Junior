#!/bin/sh
set -e
goal="Implement search bar with bg-main"
echo "Plan:"
echo "1. Modify SearchBar.jsx to use the class bg-main for the search bar."

cat > ./src/frontend/components/MultiSelect/SearchBar.jsx << 'EOF'
const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  return (
    <input 
      type="text"
      placeholder="Suggestions below. Search here!"
      value={props.searchValue()}
      onInput={handleInputChange}
      onKeyPress={props.onKeyPress}
      class="border border-gray-300 rounded p-2 w-full bg-main text-emphasize my-2"
    />
  );
};

export default SearchBar;
EOF

echo "\033[32mDone: $goal\033[0m\n"