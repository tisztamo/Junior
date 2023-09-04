const SearchBar = (props) => {
  const handleInputChange = (e) => {
    props.setSearchValue(e.target.value);
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      props.addFirstFilteredItem();
    }
  };

  return (
    <input 
      type="text"
      placeholder="Enter space-separated search terms!"
      value={props.searchValue()}
      onInput={handleInputChange}
      onKeyPress={handleKeyPress}
      class="border border-gray-300 rounded p-2 w-full bg-emphasize text-emphasize my-2"
    />
  );
};

export default SearchBar;
