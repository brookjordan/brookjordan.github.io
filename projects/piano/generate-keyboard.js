import { pianoKeys, noteFrequency } from "./note-frequency.js";

const pianoElt = document.querySelector(".piano");

let currentKeys = null;
let lastPlayedKeyName = null;
let clickHandlers = new Set();
let mouseIsDown = false;

pianoElt.addEventListener("mousedown", (e) => {
  e.preventDefault();

  mouseIsDown = true;
});
pianoElt.addEventListener("mouseup", (e) => {
  e.preventDefault();

  mouseIsDown = false;
});
pianoElt.addEventListener("mouseleave", (e) => {
  e.preventDefault();

  mouseIsDown = false;
});

pianoElt.addEventListener("touchmove", (e) => {
  e.preventDefault();

  if (!currentKeys) return;

  const hoveredElement = document.elementFromPoint(
    e.touches[0].clientX,
    e.touches[0].clientY
  );
  const hoveredKey = currentKeys.find(
    (key) => key.keyElement === hoveredElement
  );
  if (!hoveredKey || lastPlayedKeyName === hoveredKey.keyName) return;

  lastPlayedKeyName = hoveredKey.keyName;
  clickHandlers.forEach((handler) => {
    handler(hoveredKey.frequency, hoveredKey.keyName);
  });
});

export function onClick(callback) {
  clickHandlers.add(callback);
}

export function offClick(callback) {
  clickHandlers.delete(callback);
}

export function generateKeyboard(
  octaveCount,
  firstOctave = 4 - Math.floor(octaveCount / 2)
) {
  if (currentKeys) {
    currentKeys.forEach((key) => {
      key.keyElement.removeEventListener("click", key.clickHandler);
      key.keyElement.removeEventListener("touchstart", key.clickHandler);
      key.keyElement.removeEventListener("mouseenter", key.enterHandler);
    });
  }

  const painoFragment = document.createDocumentFragment();
  pianoElt.innerHTML = "";
  pianoElt.className = `piano piano--first-octave-${firstOctave} piano--octave-count-${octaveCount}`;

  const keys = Array.from({ length: octaveCount * 12 + 1 }, (_, index) => {
    const keyName = pianoKeys[index % pianoKeys.length];
    const frequency = noteFrequency(
      `${keyName}${firstOctave + Math.floor(index / pianoKeys.length)}`
    );

    const handleClick = (e) => {
      e.preventDefault();

      lastPlayedKeyName = keyName;
      clickHandlers.forEach((handler) => handler(frequency, keyName));
    };
    const handleEnter = (e) => {
      e.preventDefault();

      if (!mouseIsDown) return;

      clickHandlers.forEach((handler) => handler(frequency, keyName));
    };

    const keyElement = document.createElement("div");
    keyElement.className = "key";
    keyElement.addEventListener("mousedown", handleClick);
    keyElement.addEventListener("touchstart", handleClick);
    keyElement.addEventListener("mouseenter", handleEnter);

    painoFragment.append(keyElement);

    return {
      keyElement,
      keyName,
      frequency,
      clickHandler: handleClick,
      enterHandler: handleEnter,
    };
  });

  pianoElt.append(painoFragment);

  currentKeys = keys;
}
