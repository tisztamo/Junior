import { createEffect, onCleanup } from 'solid-js';

const AutoGrowingTextarea = (props) => {
  let textRef;
  
  const resize = () => {
    if(textRef){
      textRef.style.height = 'auto';
      textRef.style.height = textRef.scrollHeight + 'px';
    }
  }

  // Handle the input event by calling resize and any onInput function provided in props
  const handleInput = (event) => {
    if (props.onInput) {
      props.onInput(event);
    }
    resize();
  }

  createEffect(() => {
    if (props.valueSignal) {
      props.valueSignal();
    }
    resize();
  });

  // Ensuring the textarea resizes on component mount to adjust for any initial content
  onCleanup(() => {
    resize();
  });

  return (
    <textarea
      {...props}
      ref={textRef}
      onInput={handleInput}
      rows="1"
      style="overflow:hidden"
      value={props.valueSignal ? props.valueSignal() : props.value}
    />
  );
};

export default AutoGrowingTextarea;
