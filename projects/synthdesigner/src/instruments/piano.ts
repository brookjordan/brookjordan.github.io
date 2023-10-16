import { audioContext } from "../audioContext.js";
import dft from "../fourier/discreteFourierTransform.js";

const pianoWaveform = [0.2, 1, 0.8, 0.8, 0.8, 0.2, 0.2, 0];
const convertedPianoTerms = dft(pianoWaveform);

export const compilePianoWave = () =>
  audioContext.createPeriodicWave(
    convertedPianoTerms.map((coplexNumber) => coplexNumber.real),
    convertedPianoTerms.map((coplexNumber) => coplexNumber.imaginary)
  );
