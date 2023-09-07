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
