import { createEffect } from 'solid-js';

const AutoGrowingTextarea = (props) => {
  let textRef;
  
  const resize = () => {
    textRef.style.height = 'auto';
    textRef.style.height = textRef.scrollHeight + 'px';
  }

  createEffect(() => {
    if (props.valueSignal) {
      props.valueSignal();
    }
    resize();
  });

  return (
    <textarea
      {...props}
      ref={textRef}
      onInput={resize}
      rows="1"
      style="overflow:hidden"
      value={props.valueSignal ? props.valueSignal() : props.value}
    />
  );
};

export default AutoGrowingTextarea;
