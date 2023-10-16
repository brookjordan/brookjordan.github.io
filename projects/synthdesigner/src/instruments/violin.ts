import { audioContext } from "../audioContext.js";
import ComplexNumber from "../fourier/complexNumber.js";
import dft from "../fourier/discreteFourierTransform.js";
import fastFourierTransform from "../fourier/fastFourierTransform.js";

const violinWaveform = [
  4.5, 5.5, 8.5, 9.5, 3.5, 6, 2, 3, 6, 9, 10, 5, 0, 1, 2.5, 0.5, 1.5, 4, 6, 6.5,
];
const convertedViolinTerms = fastFourierTransform(
  violinWaveform.map(
    (value) => new ComplexNumber({ real: value, imaginary: 0 })
  )
);

export const compileViolinWave = () =>
  audioContext.createPeriodicWave(
    convertedViolinTerms.map((coplexNumber) => coplexNumber.real),
    convertedViolinTerms.map((coplexNumber) => coplexNumber.imaginary)
  );
