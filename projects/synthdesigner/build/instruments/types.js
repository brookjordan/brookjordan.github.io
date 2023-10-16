import * as waveCompilers from "./waveCompilers.js";
export const basicWaveTypes = [
    "sine",
    "triangle",
    "sawtooth",
    "square",
];
export const isBasicWaveType = (waveType) => waveType && basicWaveTypes.includes(waveType);
export const isInstrumentType = (waveType) => waveType && Object.keys(waveCompilers).includes(waveType);
