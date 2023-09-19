import { createSignal } from 'solid-js';

const ProofInput = () => {
  const [proof, setProof] = createSignal('');

  const handleChange = (e) => {
    setProof(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Proof..." value={proof()} onInput={handleChange} />
  );
};

export default ProofInput;
