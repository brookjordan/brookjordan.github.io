const pianoSineTerms = new Float32Array([0.2, 1, 0.8, 0.8, 0.8, 0.2, 0.2, 0]);
export const pianoTerms = [
  pianoSineTerms,
  new Float32Array(pianoSineTerms.length),
];

const violinSineTerms = new Float32Array([
  0.44, 0.54, 0.94, 0.94, 0.35, 0.57, 0.23, 0.35, 0.46, 0.94, 1, 0.94, 0.73,
  0.08, 0, 0.1, 0.23, 0.08, 0.23, 0.4, 0.58, 0.66,
]);
export const violinTerms = [
  violinSineTerms,
  new Float32Array(violinSineTerms.length),
];
