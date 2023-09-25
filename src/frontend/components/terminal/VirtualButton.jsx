import { createSignal } from 'solid-js';

const VirtualButton = (props) => {
  const sendKey = () => {
    if (props.action) {
      props.action();
    }
  };

  return (
    <button
      className="m-1 bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded"
      onClick={sendKey}
    >
      {props.label}
    </button>
  );
};

export default VirtualButton;
