import { createSignal } from 'solid-js';
import { proof, setProof } from '../model/proofModel';

const ProofInput = () => {
  const handleChange = (e) => {
    setProof(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Proof..." value={proof()} onInput={handleChange} />
  );
};

export default ProofInput;
