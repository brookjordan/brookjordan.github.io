import chordLabels from './names.js';

export const labelMap = Object.fromEntries(
  chordLabels.map((label) => [
    label,
    label.toLowerCase().replace(/[- ]\w/g, (char) => char[1].toUpperCase()),
  ])
);

const cachedChords = {};

export const get = async (_chordName, _index) => {
  const index = _index || 0;

  const chordName = (
    /-| |[A-Z]/.test(_chordName) ? labelMap[_chordName] : _chordName
  ).replace(/[A-Z]/g, (char) => `-${char.toLowerCase()}`);

  let chords;
  if (cachedChords[chordName]) {
    chords = cachedChords[chordName];
  } else {
    chords = (await import(`./spread/${chordName}.js`)).default;
    cachedChords[chordName] = chords;
  }

  if (index >= chords.length) {
    console.warn('Requested index is larger than the number of chords');
  }
  return chords[index % chords.length];
};
