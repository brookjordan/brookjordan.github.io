import * as waveCompilers from "./waveCompilers.js";

export type InstrumentType = keyof typeof waveCompilers;

export const basicWaveTypes: OscillatorType[] = [
  "sine",
  "triangle",
  "sawtooth",
  "square",
];

export const isBasicWaveType = (
  waveType: unknown
): waveType is OscillatorType =>
  waveType && basicWaveTypes.includes(waveType as OscillatorType);

export const isInstrumentType = (
  waveType: unknown
): waveType is InstrumentType =>
  waveType && Object.keys(waveCompilers).includes(waveType as InstrumentType);
