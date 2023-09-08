const handleResultSetItemClick = async (item, itemId, selectedItems) => {
    const element = document.getElementById(itemId);
    if (element) {
        element.style.transition = "opacity 0.5s, transform 0.5s";
        element.style.opacity = "0";
        element.style.transform = "translateX(-100%)";
        await new Promise(resolve => setTimeout(resolve, 500));
    }
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    return updatedItems;
};

export default handleResultSetItemClick;
