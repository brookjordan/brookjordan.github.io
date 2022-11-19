import { pianoTerms, violinTerms } from "./instruments.js";
// I’m not sure why this import doesn’t work
// import { semitoneMultiplier } from "./note-frequency.js";
const semitoneMultiplier = 2 ** (1 / 12);

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

function singleBeep(frequency, instrument = "piano") {
  const attack = instrument === "piano" ? 0.01 : 0.4;
  const hold = instrument === "piano" ? 0.05 : 0.2;
  const fade = instrument === "piano" ? 0.15 : 0.1;

  if (!ready) return;

  if (context.state !== "running") {
    context.resume && context.resume();
  }

  currentOscillatorSet = (currentOscillatorSet + 1) % oscillatorSetCount;

  const oscillator1Index = currentOscillatorSet * oscillatorSetSize;
  oscillators[oscillator1Index].osc.setPeriodicWave(
    instrument === "piano" ? pianoWave : violinWave
  );
  oscillators[oscillator1Index].osc.frequency.setValueAtTime(frequency, 0);
  // console.log({
  //   currentTime: context.currentTime,
  //   attackEnd: context.currentTime + attack,
  //   holdEnd: context.currentTime + attack + hold,
  //   fadeEnd: context.currentTime + attack + hold + fade,
  // });
  oscillators[oscillator1Index].volume.gain.setTargetAtTime(
    0.9,
    context.currentTime,
    attack
  );
  oscillators[oscillator1Index].volume.gain.setTargetAtTime(
    -1,
    context.currentTime + attack + hold,
    fade
  );
}

export function beep(frequency, instrument = "piano", chord) {
  const chordDuration = 300;
  const randomOrder = false;
  const playBackwards = false;

  if (!chord) {
    singleBeep(frequency, instrument);
    return;
  }

  const chordClone = [...chord];
  let index = 0;
  while (chordClone.length) {
    const noteFrequency =
      frequency *
      semitoneMultiplier **
        chordClone.splice(
          randomOrder
            ? Math.floor(Math.random() * chordClone.length)
            : playBackwards
            ? -1
            : 0,
          1
        )[0];

    if (index) {
      setTimeout(
        () => singleBeep(noteFrequency, instrument),
        (index * chordDuration) / chord.length - 1
      );
    } else {
      singleBeep(noteFrequency, instrument);
    }

    index += 1;
  }
}
