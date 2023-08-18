type NoteLetter = "c" | "d" | "e" | "f" | "g" | "a" | "b";

const availableNotes: Readonly<`${NoteLetter}${"♭" | ""}${5 | 6}`[]> = [
  "C5",
  "D♭5",
  "D5",
  "E♭5",
  "E5",
  "F5",
  "G♭5",
  "G5",
  "A♭5",
  "A5",
  "B♭5",
  "B5",
  "C6",
  "D♭6",
  "D6",
  "E♭6",
  "E6",
  "F6",
] as const;

let noteImages: { [SvgName: string]: SVGSVGElement } = {};
const noteImagesPromise: Promise<unknown> = Promise.all(
  [...availableNotes, "blank", "broken"].map(async (svgName) => {
    const response = await fetch(`./i/${svgName.replace("♯", "%23")}.svg`);
    const svgString = await response.text();
    const container = document.createElement("div");
    container.innerHTML = svgString;
    const svgElement = container.querySelector("svg");
    if (svgElement) {
      noteImages[svgName] = svgElement;
    }
  })
);

(async () => {
  await noteImagesPromise;
  renderSong();
})();

const staveElement = document.querySelector("#staveElement");
const songs = availableSongs as Readonly<{
  [SongName: string]: ("|" | "-" | number)[];
}>;
let selectedSongName = Object.keys(songs)[0];

function renderSong() {
  if (!staveElement) return;

  staveElement.innerHTML = "";

  let song = songs[selectedSongName];

  const maxAllowedNoteNumber = availableNotes.length - 1;

  const numberedNotes = song.filter(
    (note) => typeof note === "number"
  ) as number[];
  const maxNote = Math.max(...numberedNotes);
  const minNote = Math.min(...numberedNotes);
  const rangeDifference = maxNote - minNote - maxAllowedNoteNumber;
  const outOfRangeBy = Math.max(0, rangeDifference);

  const distanceOver = Math.max(0, maxNote - maxAllowedNoteNumber);
  const distanceUnder = Math.abs(Math.min(0, minNote));

  let reRangedSong = [...song];
  let transposedSemitones = 0;
  let errorMessage = "";

  if (maxNote - minNote > availableNotes.length - 1) {
    errorMessage = `Song out of range by ${outOfRangeBy} semitones`;
  }

  if (distanceOver || distanceUnder) {
    if (distanceUnder) {
      transposedSemitones = distanceUnder;
      reRangedSong = song.map((noteNumber) =>
        typeof noteNumber === "number" ? noteNumber + distanceUnder : noteNumber
      );
    } else {
      transposedSemitones = -distanceOver;
      reRangedSong = song.map((noteNumber) =>
        typeof noteNumber === "number" ? noteNumber - distanceOver : noteNumber
      );
    }
  }

  /* Print messages */
  if (errorMessage) {
    staveElement.append(`Error: ${errorMessage}`);
    staveElement.append(document.createElement("br"));
  }

  if (transposedSemitones) {
    staveElement.append(
      `Transposed ${transposedSemitones > 0 ? "up" : "down"} by ${Math.abs(
        transposedSemitones
      )}`
    );
    staveElement.append(document.createElement("br"));
  }

  if (rangeDifference < 0) {
    staveElement.append(
      `Song could expand its range by ${-rangeDifference} semitones`
    );
    staveElement.append(document.createElement("br"));
  }
  /* END => Print messages */

  /* Print select menu */
  const selectMenu = document.createElement("select");
  Object.keys(songs).forEach((songName) => {
    const option = document.createElement("option");
    option.textContent = songName;
    if (selectedSongName === songName) {
      option.selected = true;
    }
    selectMenu.append(option);
  });
  selectMenu.addEventListener("change", () => {
    selectedSongName = selectMenu.selectedOptions[0].value;
    renderSong();
  });
  staveElement.append(selectMenu);
  staveElement.append(document.createElement("br"));
  /* END => Print select menu */

  reRangedSong.forEach((number) => {
    if (number === "|") {
      staveElement.append(document.createElement("br"));
      return;
    } else {
      const wrapper = document.createElement("div");
      wrapper.style.display = "inline-block";
      const label = document.createElement("p");
      // undefined means out of range, null means a note wasn’t requested
      const note = typeof number === "number" ? availableNotes[number] : null;
      /** @type {SVGElement} */
      const svg =
        noteImages[
          note === undefined ? "broken" : note === null ? "blank" : note
        ].cloneNode(true);
      label.textContent = note === undefined ? "?" : note === null ? "" : note;
      wrapper.append(label);
      wrapper.appendChild(svg);
      staveElement.append(wrapper);
    }
  });
}
