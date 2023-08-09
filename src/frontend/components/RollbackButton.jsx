import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import ConfirmationDialog from './ConfirmationDialog';

const RollbackButton = () => {
  const [showConfirmation, setShowConfirmation] = createSignal(false);

  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  const handleConfirm = () => {
    setShowConfirmation(false);
    handleReset();
  };

  const handleRollbackClick = () => {
    setShowConfirmation(true);
  };

  return (
    <>
      <button className="w-full px-4 py-4 bg-red-700 text-white rounded" onClick={handleRollbackClick}>Roll Back</button>
      <ConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;
