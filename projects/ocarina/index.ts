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

function songFromUrl(): string | null {
  const fromQuery = new URLSearchParams(location.search).get("song");
  const fromHash = location.hash.replace(/^#/, "");
  const raw = fromQuery || (fromHash ? decodeURIComponent(fromHash) : "");
  if (!raw) return null;
  if (songs[raw]) return raw;
  return (
    Object.keys(songs).find(
      (name) => name.toLowerCase() === raw.toLowerCase()
    ) || null
  );
}

function syncSongToUrl(name: string) {
  const url = new URL(location.href);
  url.searchParams.set("song", name);
  url.hash = "";
  history.replaceState(null, "", url);
}

const songFromLocation = songFromUrl();
let selectedSongName = songFromLocation || Object.keys(songs)[0];
if (songFromLocation) syncSongToUrl(songFromLocation);
let userTransposeOffset = 0;
const statusElement = document.createElement("div");
const controlsElement = document.createElement("div");
const notesMount = document.createElement("div");
const formatOffset = (value: number) => `${value > 0 ? "+" : ""}${value}`;

function computeLayout() {
  const song = songs[selectedSongName];
  const maxAllowedNoteNumber = availableNotes.length - 1;
  const numberedNotes = song.filter(
    (note) => typeof note === "number"
  ) as number[];
  const maxNote = Math.max(...numberedNotes);
  const minNote = Math.min(...numberedNotes);
  const outOfRangeBy = Math.max(
    0,
    maxNote - minNote - maxAllowedNoteNumber
  );
  const distanceOver = Math.max(0, maxNote - maxAllowedNoteNumber);
  const distanceUnder = Math.abs(Math.min(0, minNote));
  let baseOffset = 0;
  let errorMessage = "";
  if (maxNote - minNote > availableNotes.length - 1) {
    errorMessage = `Song out of range by ${outOfRangeBy} semitones`;
  }
  if (distanceOver || distanceUnder) {
    baseOffset = distanceUnder ? distanceUnder : -distanceOver;
  }
  const fittedMin = minNote + baseOffset;
  const fittedMax = maxNote + baseOffset;
  const minUserOffset = errorMessage ? 0 : -fittedMin;
  const maxUserOffset = errorMessage ? 0 : maxAllowedNoteNumber - fittedMax;
  userTransposeOffset = Math.min(
    maxUserOffset,
    Math.max(minUserOffset, userTransposeOffset)
  );
  const totalOffset = baseOffset + userTransposeOffset;
  const reRangedSong = song.map((noteNumber) =>
    typeof noteNumber === "number" ? noteNumber + totalOffset : noteNumber
  );
  return {
    errorMessage,
    totalOffset,
    minUserOffset,
    maxUserOffset,
    reRangedSong,
  };
}

function renderStatus(errorMessage: string, totalOffset: number) {
  statusElement.innerHTML = "";
  if (errorMessage) {
    statusElement.append(`Error: ${errorMessage}`);
    statusElement.append(document.createElement("br"));
  }
  if (totalOffset) {
    statusElement.append(
      `Transposed ${totalOffset > 0 ? "up" : "down"} by ${Math.abs(
        totalOffset
      )}`
    );
    statusElement.append(document.createElement("br"));
  }
}

function renderNotes(reRangedSong: ("|" | "-" | number)[]) {
  notesMount.innerHTML = "";
  reRangedSong.forEach((number) => {
    if (number === "|") {
      notesMount.append(document.createElement("br"));
      return;
    }
    const wrapper = document.createElement("div");
    wrapper.style.display = "inline-block";
    const label = document.createElement("p");
    const note = typeof number === "number" ? availableNotes[number] : null;
    const svg =
      noteImages[
        note === undefined ? "broken" : note === null ? "blank" : note
      ].cloneNode(true);
    label.textContent = note === undefined ? "?" : note === null ? "" : note;
    wrapper.append(label);
    wrapper.appendChild(svg);
    notesMount.append(wrapper);
  });
}

function renderSong() {
  if (!staveElement) return;

  const {
    errorMessage,
    totalOffset,
    minUserOffset,
    maxUserOffset,
    reRangedSong,
  } = computeLayout();

  staveElement.innerHTML = "";
  controlsElement.innerHTML = "";
  renderStatus(errorMessage, totalOffset);

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
    userTransposeOffset = 0;
    syncSongToUrl(selectedSongName);
    renderSong();
  });
  controlsElement.append(selectMenu);
  controlsElement.append(document.createElement("br"));

  if (maxUserOffset > minUserOffset) {
    const transposeRow = document.createElement("label");
    transposeRow.style.display = "inline-flex";
    transposeRow.style.alignItems = "center";
    transposeRow.style.gap = "0.5rem";
    transposeRow.style.margin = "0.5rem 0";
    const transposeLabel = document.createElement("span");
    transposeLabel.textContent = `Shift ${formatOffset(userTransposeOffset)}`;
    const transposeSlider = document.createElement("input");
    transposeSlider.type = "range";
    transposeSlider.min = String(minUserOffset);
    transposeSlider.max = String(maxUserOffset);
    transposeSlider.step = "1";
    transposeSlider.value = String(userTransposeOffset);
    transposeSlider.setAttribute(
      "aria-label",
      `Transpose within ${maxUserOffset - minUserOffset} semitones`
    );
    const transposeBounds = document.createElement("span");
    transposeBounds.style.opacity = "0.7";
    transposeBounds.textContent = `(${formatOffset(
      minUserOffset
    )}…${formatOffset(maxUserOffset)})`;
    transposeSlider.addEventListener("input", () => {
      userTransposeOffset = Number(transposeSlider.value);
      transposeLabel.textContent = `Shift ${formatOffset(userTransposeOffset)}`;
      const layout = computeLayout();
      renderStatus(layout.errorMessage, layout.totalOffset);
      renderNotes(layout.reRangedSong);
    });
    transposeRow.append(transposeLabel, transposeSlider, transposeBounds);
    controlsElement.append(transposeRow);
    controlsElement.append(document.createElement("br"));
  }

  staveElement.append(statusElement, controlsElement, notesMount);
  renderNotes(reRangedSong);
}
