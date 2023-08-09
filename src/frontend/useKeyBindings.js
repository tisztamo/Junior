const useKeyBindings = (bindings) => {
  const handler = (e) => {
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
