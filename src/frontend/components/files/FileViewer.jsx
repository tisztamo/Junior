import SourceFileDisplay from '../files/SourceFileDisplay';
import { FileViewerHeader } from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50">
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-emphasize w-full mx-2 max-h-3/4 rounded-lg">
          <FileViewerHeader onClose={props.onClose} path={props.path} />
          <div class="overflow-y-auto h-full">
            <SourceFileDisplay path={props.path} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
