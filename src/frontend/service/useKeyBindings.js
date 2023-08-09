const useKeyBindings = (bindings) => {
  const handler = (e) => {
    // Ignore bindings if target is input or textarea
    if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') {
      return;
    }
    const action = bindings[e.key.toUpperCase()];
    if (action) {
      action(e);
    }
  };

  window.addEventListener('keydown', handler);

  return () => {
    window.removeEventListener('keydown', handler);
  };
};

export default useKeyBindings;
