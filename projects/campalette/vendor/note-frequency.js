function noteWavelength(offset) {
  // A4 has a defined, integer frequency. Let's use this as the base for calculations
  const A4Frequency   = 440;
  // Allows:
  //   - multiple flats and sharps in any order
  //   - usage of '♭' or lowercase 'B' as flat
  const noteRegExp         = /^([a-g])([♭b#]*)(-?\d+)?$/;
  const semitoneMultiplier = 2 ** (1/12);
  const scaleNoteCount     = 12;
  // Pre calculate offsets of each note from A
  // Octaves start at C so notes after B are negative
  const noteOffsets = {
    a:  0,
    b:  2,
    c: -9,
    d: -7,
    e: -5,
    f: -4,
    g: -2,
  };
  // Allow null or undefined to default to a 0 offset
  offset = offset || 0;

  // If a number is provided, use it directly as the offset
  if (!isNaN(+offset)) {
    // Decimals don't make sense, so we'll throw
    if (+offset % 1) {
      throw formattingError();
    }
  }

  // Otherwise we'll try to calculate it from the string
  else if (typeof offset === 'string') {
    // Let's strip white spaces and lowercase everything so we know what we're dealing with
    let offsetString = offset.replace(/\s+/g, '').toLowerCase();
    if (!noteRegExp.test(offsetString)) {
      throw formattingError();
    }

    // Pull the relevant information out of the RegExp
    let [, note, sharpsAndFlats, octave = 4] = noteRegExp.exec(offsetString);
    let sharpCount = (sharpsAndFlats.match(/#/g)    || []).length;
    let flatCount  = (sharpsAndFlats.match(/[♭b]/g) || []).length;
    let noteOffset = (sharpCount - flatCount + scaleNoteCount) % scaleNoteCount;

    offset = ((noteOffsets[note] + noteOffset) % scaleNoteCount) + ((octave - 4) * scaleNoteCount);
  }

  // Non strings / number / undefined / null will throw an error
  else {
    throw formattingError();
  }

  return +(A4Frequency * semitoneMultiplier ** offset).toFixed(10);

  function formattingError() {
    return new Error(`${ offset } is not a valid note.
      Please provide either:
        - null or undefined to get the frequency of A4
        - an integer number representing a semi-tone offset from A4
        - a string depicting a note in the form '${ noteRegExp }'
      That is:
        The note letter[, flats and sharps][, the octave number]
      If not stated otherwise:
        - No sharps or flats are included
        - The octave defaults to 4`.replace(/\n {6}/g, '\n'));
  }
}
