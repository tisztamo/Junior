import SourceFileDisplay from '../files/SourceFileDisplay';
import FileViewerHeader from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50 bg-gray-500 bg-opacity-50">
      <div class="absolute inset-0 h-full flex justify-center items-center">
        <div class="bg-emphasize w-full mx-2 h-full rounded-lg">
          <FileViewerHeader onClose={props.onClose} path={props.path} />
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
