import SourceFileDisplay from '../files/SourceFileDisplay';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto">
          <div class="absolute top-4 right-4" onClick={props.onClose}></div>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
