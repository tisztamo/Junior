import { createSignal } from 'solid-js';

const VirtualKey = (props) => {
  const sendKey = () => {
    if (props.action) {
      props.action();
    }
  };

  return (
    <button
      className="text-text m-1 bg-main hover:bg-blue-500 font-bold py-2 px-3 rounded" 
      onClick={sendKey}
    >
      {props.label}
    </button>
  );
};

export default VirtualKey;
