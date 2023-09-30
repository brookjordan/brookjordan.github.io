import { beep } from "./beep.js";
import { generateKeyboard, onClick } from "./generate-keyboard.js";
import {
  getNoteParts,
  noteDescriptorFromOffsetFromA4,
} from "./note-frequency.js";
import chordLabels from "./chords/names.js";
import { get as getChord } from "./chords/promises.js";

const chordOptions = document.createDocumentFragment();
chordLabels.forEach((label) => {
  const option = document.createElement("option");
  option.textContent = label;
  chordOptions.append(option);
});
chord_names.append(chordOptions);

let chord;
chord_names.addEventListener("change", async () => {
  chord =
    chord_names.value === "None"
      ? undefined
      : await getChord(chord_names.value);
});

octave_count_value.innerHTML = octave_count_input.valueAsNumber;
octave_offset_value.innerHTML = octave_offset_input.value = Math.floor(
  4.5 - octave_count_input.valueAsNumber / 2
);
generateKeyboard(
  octave_count_input.valueAsNumber,
  octave_offset_input.valueAsNumber
);

octave_count_input.addEventListener("input", () => {
  octave_count_value.innerHTML = octave_count_input.valueAsNumber;
  octave_offset_value.innerHTML = octave_offset_input.value = Math.floor(
    4.5 - octave_count_input.valueAsNumber / 2
  );

  generateKeyboard(
    octave_count_input.valueAsNumber,
    octave_offset_input.valueAsNumber
  );
});

octave_offset_input.addEventListener("input", () => {
  octave_offset_value.innerHTML = octave_offset_input.valueAsNumber;

  generateKeyboard(
    octave_count_input.valueAsNumber,
    octave_offset_input.valueAsNumber
  );
});

instrument_value.innerHTML = `Instrument: ${instrument_select.value}`;
instrument_select.addEventListener("change", () => {
  instrument_value.innerHTML = `Instrument: ${instrument_select.value}`;
});

onClick(async (frequency, keyName, noteDescriptor) => {
  const noteParts = getNoteParts(noteDescriptor);
  // console.log(noteParts.offsetFromA4);
  // console.log(noteDescriptor);
  // const frequencies = chord ? chord.map() : [frequency];
  // console.log(
  //   chord
  //     ? chord.map((offset) =>
  //         noteDescriptorFromOffsetFromA4(noteParts.offsetFromA4 + offset)
  //       )
  //     : noteDescriptorFromOffsetFromA4(noteParts.offsetFromA4)
  // );
  beep(frequency, instrument_select.value, chord);
});
