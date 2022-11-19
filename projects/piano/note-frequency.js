// A4 has a defined, integer frequency. Let's use this as the base for calculations
export const A4Frequency = 440;
export const semitoneMultiplier = 2 ** (1 / 12);

// Allows:
//   - multiple flats and sharps in any order
//   - usage of '♭' or lowercase 'B' as flat
//   - usage of '♯' or '#' as sharp
const noteRegExp = /^([a-gA-G])([♭b♯#]*)(-?\d+)?$/;
const scaleNoteCount = 12;

// Pre calculate offsets of each note from A
// Octaves start at C so notes after B are negative
export const noteOffsetFromA = {
  a: 0,
  "a♯": 1,
  "b♭": 1,
  b: 2,
  c: -9,
  "c♯": -8,
  "d♭": -8,
  d: -7,
  "d♯": -6,
  "e♭": -6,
  e: -5,
  f: -4,
  "f♯": -3,
  "g♭": -3,
  g: -2,
  "g♯": -1,
  "a♭": -1,
};

export const pianoKeys = [
  "c",
  "c♯",
  "d",
  "d♯",
  "e",
  "f",
  "f♯",
  "g",
  "g♯",
  "a",
  "a♯",
  "b",
];

/**
 * @param {number} offset
 * @return {Error}
 */
const formattingError = (offset) =>
  new Error(
    `${offset} is not a valid note.
Please provide either:
  - null or undefined to get the frequency of A4
  - an integer number representing a semi-tone offset from A4
  - a string depicting a note in the form '${noteRegExp}'
That is:
  The note letter[, flats and sharps][, the octave number]
If not stated otherwise:
  - No sharps or flats are included
  - The octave defaults to 4`
  );

function frequencyAtOffset(offsetFromA4) {
  return +(A4Frequency * semitoneMultiplier ** offsetFromA4);
}

/**
 * @param {number|string} offset
 * @return {number} The frequency of the note
 */
export function noteFrequency(offset) {
  // If a number is provided, use it directly as the offset
  if (!isNaN(+offset)) {
    // Decimals don't make sense, so we'll throw
    if (+offset % 1) {
      throw formattingError(offset);
    }
  }

  // Otherwise we'll try to calculate it from the string
  else if (typeof offset === "string") {
    // Let's strip white spaces and lowercase everything so we know what we're dealing with
    let offsetString = offset.replace(/\s+/g, "").toLowerCase();
    if (!noteRegExp.test(offsetString)) {
      throw formattingError(offset);
    }

    // Pull the relevant information out of the RegExp
    let [, note, sharpsAndFlats, octave = noteOffsetFromA[note] > -2 ? 3 : 4] =
      noteRegExp.exec(offsetString);
    let sharpCount = (sharpsAndFlats.match(/[♯#]/g) || []).length;
    let flatCount = (sharpsAndFlats.match(/[♭b]/g) || []).length;
    let noteOffset = (sharpCount - flatCount + scaleNoteCount) % scaleNoteCount;

    offset =
      ((noteOffsetFromA[note] + noteOffset) % scaleNoteCount) +
      (octave - 4) * scaleNoteCount;
  }

  // Non strings / number / undefined / null will throw an error
  else {
    throw formattingError(offset);
  }

  return +frequencyAtOffset(offset).toFixed(10);
}
