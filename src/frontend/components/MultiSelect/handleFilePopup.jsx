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
