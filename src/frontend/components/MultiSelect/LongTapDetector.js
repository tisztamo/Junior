import { onCleanup } from 'solid-js';

const useLongTap = (callback, duration = 500) => {
  let timer;

  const startLongTapDetection = () => {
    timer = setTimeout(callback, duration);
  };

  const cancelLongTapDetection = () => {
    clearTimeout(timer);
  };

  onCleanup(() => {
    clearTimeout(timer);
  });

  return {
    onTouchStart: startLongTapDetection,
    onTouchEnd: cancelLongTapDetection,
    onMouseDown: startLongTapDetection,
    onMouseUp: cancelLongTapDetection,
    onMouseLeave: cancelLongTapDetection
  };
};

export default useLongTap;
