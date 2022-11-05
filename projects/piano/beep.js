import { pianoTerms, violinTerms } from "./instruments.js";

let context;
let pianoWave;
let violinWave;

const oscillatorSetSize = 1;
const oscillatorSetCount = 10;
const oscillators = [];
let currentOscillatorSet = 0;

let ready = false;

const init = () => {
  if (ready) return;

  if (!window.AudioContext && !window.webkitAudioContext) {
    alert("Your device doesn’t support web audio");
    return;
  }

  window.removeEventListener("mousedown", init);
  window.removeEventListener("touchstart", init);

  context = new (window.AudioContext || window.webkitAudioContext)();

  pianoWave = context.createPeriodicWave(...pianoTerms);
  violinWave = context.createPeriodicWave(...violinTerms);

  oscillators.push(
    ...Array.from({ length: oscillatorSetCount * oscillatorSetSize }, () => {
      const osc = context.createOscillator();
      const volume = context.createGain();
      volume.connect(context.destination);
      volume.gain.setTargetAtTime(-1, 0, 0);
      osc.frequency.setValueAtTime(0, 0);
      osc.connect(volume);
      osc.connect(context.destination);
      osc.start();

      return {
        osc,
        volume,
      };
    })
  );

  ready = true;
};

window.addEventListener("mousedown", init, { once: true, capture: true });
window.addEventListener("touchstart", init, {
  once: true,
  capture: true,
});

export function beep(frequency, instrument = "piano") {
  const attack = 0.01;

  if (!ready) return;

  if (context.state !== "running") {
    context.resume && context.resume();
  }

  currentOscillatorSet = (currentOscillatorSet + 1) % oscillatorSetCount;

  const oscillator1Index = currentOscillatorSet * oscillatorSetSize;
  oscillators[oscillator1Index].osc.setPeriodicWave(instrument === "piano" ? pianoWave : violinWave);
  oscillators[oscillator1Index].osc.frequency.setValueAtTime(frequency, 0);
  oscillators[oscillator1Index].volume.gain.setTargetAtTime(0.9, 0, attack);
  setTimeout(() => {
    oscillators[oscillator1Index].volume.gain.setTargetAtTime(-1, 0, 0.1);
  }, attack * 1000);
}
