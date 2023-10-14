import { init } from "./audioContext.js";
import { middleNoteFrequencies, noteFrequencies } from "./noteFrequencies.js";
import { endAllNotes, playNote } from "./playNote.js";

const stop_sound = document.getElementById("stop_sound") as HTMLButtonElement;
const attack_ms = document.getElementById("attack_ms") as HTMLInputElement;
const wave_shape = document.getElementById("wave_shape") as HTMLSelectElement;
const force_full_attack = document.getElementById(
  "force_full_attack"
) as HTMLInputElement;
const decay_ms = document.getElementById("decay_ms") as HTMLInputElement;
const sustain_volume = document.getElementById(
  "sustain_volume"
) as HTMLInputElement;
const release_ms = document.getElementById("release_ms") as HTMLInputElement;

const click_to_start = document.getElementById("click_to_start");
const middleNoteFrequencyList = ["c", "d", "g", "g#", "e", "a"].flatMap(
  (note) => [
    noteFrequencies[3][note],
    noteFrequencies[4][note],
    noteFrequencies[5][note],
  ]
);

stop_sound.addEventListener("click", () => {
  endAllNotes();
});

window.addEventListener(
  "mousedown",
  () => {
    init();
    click_to_start.remove();
  },
  { once: true, capture: true }
);

document.body.addEventListener("mousedown", (e) => {
  if (e.target !== document.body) return;

  const note = playNote({
    frequency:
      middleNoteFrequencyList[
        Math.floor(Math.random() * middleNoteFrequencyList.length)
      ],
    waveShape: wave_shape.selectedOptions[0].value as OscillatorType,
    attack: attack_ms.valueAsNumber || 0,
    forceFullAttack: force_full_attack.checked || false,
    decay: decay_ms.valueAsNumber || 0,
    sustain: sustain_volume.valueAsNumber || 0,
    release: release_ms.valueAsNumber || 0,
  });

  window.addEventListener(
    "mouseup",
    () => {
      note.release();
    },
    { once: true }
  );
});
