export const sharpNotes = [
  "c",
  "c#",
  "d",
  "d#",
  "e",
  "f",
  "f#",
  "g",
  "g#",
  "a",
  "a#",
  "b",
] as const;

export const flatNotes = [
  "c",
  "db",
  "d",
  "eb",
  "e",
  "f",
  "gb",
  "g",
  "ab",
  "a",
  "bb",
  "b",
] as const;

export type NoteName = (typeof sharpNotes)[number] | (typeof flatNotes)[number];
export type NoteDescriptor = `${NoteName}${
  | "0"
  | "1"
  | "2"
  | "3"
  | "4"
  | "5"
  | "6"
  | "7"
  | "8"
  | "9"}`;

const a4Frequency = 440;
const semitoneMultiplier = 2 ** (1 / sharpNotes.length);

const a4MidiNote = 69;
const a4PianoNote = 49;
const a4OrganNote = 34;

export const noteFrequencies = Array.from({ length: 11 }, (_, octaveIndex) =>
  Object.fromEntries(
    sharpNotes.map((note, noteIndex) => [
      note,
      a4Frequency *
        semitoneMultiplier **
          (sharpNotes.length * octaveIndex + noteIndex + 12 - a4MidiNote),
    ])
  )
);

export const middleNoteFrequencies = noteFrequencies[4];

export const midiFrequencies = Array.from(
  { length: 130 },
  (_, i) => a4Frequency * semitoneMultiplier ** (i - a4MidiNote)
);
export const midiNotes = Array.from(
  { length: 130 },
  (_, i) =>
    sharpNotes[i % sharpNotes.length] + Math.floor(i / sharpNotes.length)
);

export const pianoFrequencies = Array.from(
  { length: 90 },
  (_, i) => a4Frequency * semitoneMultiplier ** (i - a4PianoNote)
);
export const pianoNotes = Array.from(
  { length: 90 },
  (_, i) =>
    sharpNotes[i % sharpNotes.length] + Math.floor(i / sharpNotes.length)
);

export const organFrequencies = Array.from(
  { length: 63 },
  (_, i) => a4Frequency * semitoneMultiplier ** (i - a4OrganNote)
);
export const organNotes = Array.from(
  { length: 63 },
  (_, i) =>
    sharpNotes[i % sharpNotes.length] + Math.floor(i / sharpNotes.length)
);
