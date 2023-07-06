const PromptDisplay = ({prompt}) => {
  return (
    <div innerHTML={prompt()}></div>
  );
};

export default PromptDisplay;
