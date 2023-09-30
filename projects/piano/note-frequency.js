// Allows:
//   - multiple flats and sharps in any order
//   - usage of '♭' or lowercase 'B' as flat
//   - usage of '♯' or '#' as sharp
const noteRegExp = /^([a-gA-G])([♭b♯#]*)(-?\d+)?$/;
const scaleNoteCount = 12;

// A4 has a defined, integer frequency. Let's use this as the base for calculations
// export const A4Frequency = 430.54; // this makes middle C ~256 hz
export const A4Frequency = 440;
export const semitoneMultiplier = 2 ** (1 / scaleNoteCount);

const sharpMatcher = /[♯#]/;
const flatMatcher = /[♭b]/;

class Note {
  #initial;
  #initiaLetter;
  #letter;
  #note;
  #sharpsAndFlats;
  #sharpness;
  #offsetFromA4;
  #octave;
  #frequency;

  get initial() {
    return this.#initial;
  }

  get initiaLetter() {
    return this.#initiaLetter;
  }

  get letter() {
    return this.#letter;
  }

  get note() {
    return this.#note;
  }

  get sharpsAndFlats() {
    return this.#sharpsAndFlats;
  }

  get sharpness() {
    return this.#sharpness;
  }

  get offsetFromA4() {
    return this.#offsetFromA4;
  }

  get octave() {
    return this.#octave;
  }

  get frequency() {
    return this.#frequency;
  }

  constructor(initial) {
    let {
      note: initiaLetter,
      sharpsAndFlats,
      octave,
      offsetFromA4,
    } = getNoteParts(initial);

    this.#initial = initial;
    this.#initiaLetter = initiaLetter;
    this.#note = getNoteFromOffsetFromA(offsetFromA4);
    this.#letter = this.#note[0];
    this.#offsetFromA4 = offsetFromA4;
    this.#sharpsAndFlats = sharpsAndFlats;
    this.#sharpness = this.#note[1] && sharpMatcher.test(this.#note[1]) ? 1 : 0;
    this.#octave = octave;
    this.#frequency = noteFrequency(this.#offsetFromA4);
  }
}
window.Note = Note;

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

const offsetFromANotes = {
  0: "a",
  1: "a♯",
  2: "b",
  3: "c",
  4: "c♯",
  5: "d",
  6: "d♯",
  7: "e",
  8: "f",
  9: "f♯",
  10: "g",
  11: "g♯",
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

const getNoteOffsetFromA = (note) => noteOffsetFromA[note] || null;

const getNoteFromOffsetFromA = (offsetFromA) => {
  let fixedOffset = offsetFromA % scaleNoteCount;
  if (fixedOffset < 0) {
    fixedOffset += scaleNoteCount;
  }
  return offsetFromANotes[fixedOffset];
};

export const noteDescriptorFromOffsetFromA4 = (offsetFromA4) => {
  const note = getNoteFromOffsetFromA(offsetFromA4);
  let octave = Math.floor((offsetFromA4 + (scaleNoteCount * (noteOffsetFromA[note] > -2 ? 3 : 4))) / scaleNoteCount);
  if (noteOffsetFromA[note] <= -1) {
    octave += 1;
  }
  return `${note}${octave}`;
};

export const getNoteParts = (noteDescriptor) => {
  if (!noteRegExp.test(noteDescriptor)) {
    throw formattingError(noteDescriptor);
  }

  let [, note, sharpsAndFlats, octave = noteOffsetFromA[note] > -2 ? 3 : 4] =
    noteRegExp.exec(noteDescriptor);

  const sharpness = +sharpsAndFlats
    .split("")
    .reduce(
      (sharpness, char) =>
        sharpMatcher.test(char)
          ? sharpness + 1
          : flatMatcher.test(char)
          ? sharpness - 1
          : sharpness,
      0
    );

  const simpleSharpsOrFlats =
    sharpness > 0
      ? Array.from({ length: sharpness }, () => "♯").join("")
      : sharpness < 0
      ? Array.from({ length: Math.abs(sharpness) }, () => "♭").join("")
      : "";

  return {
    note,
    sharpsAndFlats: simpleSharpsOrFlats,
    octave,
    offsetFromA4:
      +(getNoteOffsetFromA(note) +
      (+octave - (4)) * scaleNoteCount +
      sharpness),
  };
};

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

    // Pull the relevant information out of the RegExp
    let { note, sharpsAndFlats, octave } = getNoteParts(offsetString);
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
