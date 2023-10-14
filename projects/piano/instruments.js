import ComplexNumber from "./fourier/complexNumber.js";
import dft from "./fourier/discreteFourierTransform.js";
import fastFourierTransform from "./fourier/fastFourierTransform.js";

const start = performance.now();
const pianoWaveform = [0.2, 1, 0.8, 0.8, 0.8, 0.2, 0.2, 0];
const convertedPianoTerms = dft(
  [...pianoWaveform].map((value) => new ComplexNumber({ re: value, im: 0 }))
);
export const pianoTerms = [
  convertedPianoTerms.map((coplexNumber) => coplexNumber.re),
  convertedPianoTerms.map((coplexNumber) => coplexNumber.im),
];

const violinWaveform = [
  4.5, 5.5, 8.5, 9.5, 3.5, 6, 2, 3, 6, 9, 10, 5, 0, 1, 2.5, 0.5, 1.5, 4, 6, 6.5,
];
const convertedViolinTerms = dft(
  [...violinWaveform].map((value) => new ComplexNumber({ re: value, im: 0 }))
);
export const violinTerms = [
  convertedViolinTerms.map((coplexNumber) => coplexNumber.re),
  convertedViolinTerms.map((coplexNumber) => coplexNumber.im),
];
console.log(performance.now() - start);
