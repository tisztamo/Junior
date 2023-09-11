const handleResultSetItemClick = async (item, itemId, selectedItems) => {
    const element = document.getElementById(itemId);
    if (element) {
        element.style.transition = "opacity 0.3s, transform 0.3s";
        element.style.opacity = "0";
        element.style.transform = "scaleY(0)";
        await new Promise(resolve => setTimeout(resolve, 300));
    }
    const updatedItems = selectedItems().filter(selectedItem => selectedItem !== item);
    return updatedItems;
};

export default handleResultSetItemClick;
