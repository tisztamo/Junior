import { onCleanup } from 'solid-js';

const useLongTap = (callback, duration = 500) => {
  let timer;
  let touchStartY = null;
  const scrollThreshold = 10;  // 10 pixels

  const startLongTapDetection = (e) => {
    if (e.type === 'touchstart') {
      touchStartY = e.touches[0].clientY;
    }
    timer = setTimeout(callback, duration);
  };

  const cancelLongTapDetection = (e) => {
    if (e.type === 'touchmove' && touchStartY !== null) {
      if (Math.abs(touchStartY - e.touches[0].clientY) > scrollThreshold) {
        clearTimeout(timer);
      }
    } else {
      clearTimeout(timer);
    }
  };

  onCleanup(() => {
    clearTimeout(timer);
  });

  return {
    onTouchStart: startLongTapDetection,
    onTouchEnd: cancelLongTapDetection,
    onTouchMove: cancelLongTapDetection,
    onMouseDown: startLongTapDetection,
    onMouseUp: cancelLongTapDetection,
    onMouseLeave: cancelLongTapDetection
  };
};

export default useLongTap;

