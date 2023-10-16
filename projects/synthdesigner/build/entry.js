import { init } from "./audioContext.js";
import { noteFrequencies } from "./noteFrequencies.js";
import { endAllNotes, playNote } from "./playNote.js";
const stop_sound = document.getElementById("stop_sound");
const attack_ms = document.getElementById("attack_ms");
const wave_shape = document.getElementById("wave_shape");
const force_full_attack = document.getElementById("force_full_attack");
const decay_ms = document.getElementById("decay_ms");
const sustain_volume = document.getElementById("sustain_volume");
const release_ms = document.getElementById("release_ms");
const click_to_start = document.getElementById("click_to_start");
const cPentatonicBebopOctaves3to5Notes = [
    "c",
    "d",
    "g",
    "g#",
    "e",
    "a",
].flatMap((note) => [
    noteFrequencies[3][note],
    noteFrequencies[4][note],
    noteFrequencies[5][note],
]);
stop_sound.addEventListener("click", (e) => {
    e.preventDefault();
    endAllNotes();
});
const handleInit = (e) => {
    init();
    click_to_start.remove();
};
window.addEventListener("mousedown", handleInit, { once: true, capture: true });
window.addEventListener("touchstart", handleInit, {
    once: true,
    capture: true,
});
const handleNotePlayRequest = (e) => {
    if (e.target !== document.body)
        return;
    e.preventDefault();
    const note = playNote({
        frequency: cPentatonicBebopOctaves3to5Notes[Math.floor(Math.random() * cPentatonicBebopOctaves3to5Notes.length)],
        waveShape: wave_shape.selectedOptions[0].value,
        attack: attack_ms.valueAsNumber || 0,
        forceFullAttack: force_full_attack.checked || false,
        decay: decay_ms.valueAsNumber || 0,
        sustain: sustain_volume.valueAsNumber || 0,
        release: release_ms.valueAsNumber || 0,
    });
    window.addEventListener("mouseup", () => {
        note.release();
    }, { once: true });
    window.addEventListener("touchend", () => {
        note.release();
    }, { once: true });
};
document.body.addEventListener("mousedown", handleNotePlayRequest);
document.body.addEventListener("touchstart", handleNotePlayRequest);
