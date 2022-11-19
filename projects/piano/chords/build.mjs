import { writeFile } from "fs/promises";

const namedChords = [
  { name: "augmented", chords: [[0, 4, 8]] },
  { name: "augmentedEleventh", chords: [[0, 4, 7, 10, 2, 6]] },
  { name: "augmentedMajorSeventh", chords: [[0, 4, 8, 11]] },
  { name: "augmentedSeventh", chords: [[0, 4, 8, 10]] },
  {
    name: "augmentedSixth",
    chords: [
      [0, 4, 10],
      [0, 4, 6, 10],
      [0, 4, 7, 10],
    ],
  },
  { name: "diminished", chords: [[0, 3, 6]] },
  { name: "diminishedMajorSeventh", chords: [[0, 3, 6, 11]] },
  { name: "diminishedSeventh", chords: [[0, 3, 6, 9]] },
  { name: "dominant", chords: [[0, 4, 7]] },
  { name: "dominantEleventh", chords: [[0, 4, 7, 10, 2, 5]] },
  { name: "dominantMinorNinth", chords: [[0, 4, 7, 10, 1]] },
  { name: "dominantNinth", chords: [[0, 4, 7, 10, 2]] },
  { name: "dominantParallel", chords: [[0, 3, 7]] },
  { name: "dominantSeventh", chords: [[0, 4, 7, 10]] },
  { name: "dominantSeventhFlatFive", chords: [[0, 4, 6, 10]] },
  { name: "dominantSeventhSharpNine", chords: [[0, 4, 7, 10, 3]] },
  { name: "dominantThirteenth", chords: [[0, 4, 7, 10, 2, 5, 9]] },
  { name: "dream", chords: [[0, 5, 6, 7]] },
  { name: "elektra", chords: [[0, 7, 9, 1, 4]] },
  { name: "farben", chords: [[0, 8, 11, 4, 9]] },
  { name: "halfDiminishedSeventh", chords: [[0, 3, 6, 10]] },
  { name: "harmonicSeventh", chords: [[0, 4, 7, 10]] },
  { name: "leadingToneTriad", chords: [[0, 3, 6]] },
  { name: "lydian", chords: [[0, 4, 7, 11, 6]] },
  { name: "magic", chords: [[0, 1, 5, 6, 10, 0, 3, 5]] },
  { name: "major", chords: [[0, 4, 7]] },
  { name: "majorEleventh", chords: [[0, 4, 7, 11, 2, 5]] },
  { name: "majorSeventh", chords: [[0, 4, 7, 11]] },
  { name: "majorSeventhSharpEleventh", chords: [[0, 4, 8, 11, 6]] },
  { name: "majorSixth", chords: [[0, 4, 7, 9]] },
  { name: "majorSixthNinth", chords: [[0, 4, 7, 9, 2]] },
  { name: "majorNinth", chords: [[0, 4, 7, 11, 2]] },
  { name: "majorThirteenth", chords: [[0, 4, 7, 11, 2, 6, 9]] },
  { name: "mediant", chords: [[0, 3, 7]] },
  { name: "minor", chords: [[0, 3, 7]] },
  { name: "minorEleventh", chords: [[0, 3, 7, 10, 2, 5]] },
  { name: "minorMajorSeventh", chords: [[0, 3, 7, 11]] },
  { name: "minorNinth", chords: [[0, 3, 7, 10, 2]] },
  { name: "minorSeventh", chords: [[0, 3, 7, 10]] },
  { name: "minorSixth", chords: [[0, 3, 7, 9]] },
  { name: "minorSixthNinth", chords: [[0, 3, 7, 9, 2]] },
  { name: "minorThirteenth", chords: [[0, 3, 7, 10, 2, 5, 9]] },
  { name: "mystic", chords: [[0, 6, 10, 4, 9, 2]] },
  { name: "neapolitan", chords: [[1, 5, 8]] },
  { name: "ninthAugmentedFifth", chords: [[0, 4, 8, 10, 2]] },
  { name: "ninthFlatFifth", chords: [[0, 4, 6, 10, 2]] },
  { name: "northernLights", chords: [[1, 2, 8, 0, 3, 6, 7, 10, 11, 4, 7]] },
  { name: "hexachord", chords: [[0, 1, 4, 5, 8, 9]] },
  { name: "petrushka", chords: [[0, 1, 4, 6, 7, 10]] },
  { name: "power", chords: [[0, 7]] },
  { name: "psalms", chords: [[0, 3, 7]] },
  { name: "secondaryDominant", chords: [[0, 4, 7]] },
  { name: "secondaryLeadingTone", chords: [[0, 3, 6]] },
  { name: "secondarySupertonic", chords: [[0, 3, 7]] },
  { name: "sevenSix", chords: [[0, 4, 7, 9, 10]] },
  { name: "seventhSuspensionFour", chords: [[0, 5, 7, 10]] },
  { name: "soWhat", chords: [[0, 5, 10, 3, 7]] },
  { name: "suspended", chords: [[0, 5, 7]] },
  { name: "subdominant", chords: [[0, 4, 7]] },
  { name: "subdominantParallel", chords: [[0, 3, 7]] },
  { name: "submediant", chords: [[0, 3, 7]] },
  { name: "subtonic", chords: [[0, 4, 7]] },
  { name: "supertonic", chords: [[0, 3, 7]] },
  {
    name: "thirteenthFlatNinth",
    chords: [
      [0, 4, 7, 10, 1, 5, 9],
      [0, 4, 7, 10, 1, 6, 9],
      [0, 4, 7, 10, 1, 9],
    ],
  },
  {
    name: "thirteenthFlatNinthFlatFifth",
    chords: [
      [0, 4, 6, 10, 1, 5, 9],
      [0, 4, 6, 10, 1, 6, 9],
      [0, 4, 6, 10, 1, 9],
    ],
  },
  { name: "tonicCounterParallel", chords: [[0, 3, 7]] },
  { name: "tonic", chords: [[0, 4, 7]] },
  { name: "tonicParallel", chords: [[0, 3, 7]] },
  { name: "tristan", chords: [[0, 3, 6, 10]] },
  {
    name: "vienneseTrichord",
    chords: [
      [0, 1, 6],
      [0, 6, 7],
    ],
  },
];


const mapToSuperFlat = (chord) =>
  chord.filter((a, i, arr) => arr.indexOf(a) === i).sort((a, b) => a - b);

const mapToSpread = (chord) => {
  let level = 0;
  return chord.map((num, index, arr) => {
    if (index && num <= arr[index - 1]) {
      level += 1;
    }
    return num + 12 * level;
  });
};

namedChords.forEach(({ name, chords }) => {
  writeFile(
    `./ordered/${name.replace(/[A-Z]/g, (a) => `-${a.toLowerCase()}`)}.js`,
    `export default ${JSON.stringify(chords, null, 2)};\n`
  );
});
