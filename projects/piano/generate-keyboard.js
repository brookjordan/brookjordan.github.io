import { pianoKeys, noteFrequency } from "./note-frequency.js";

const pianoElt = document.querySelector(".piano");

export let currentKeys = [];
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
    handler(
      hoveredKey.frequency,
      hoveredKey.keyName,
      hoveredKey.noteDescriptor
    );
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
      key.keyElement.removeEventListener("mousedown", key.pressHandler);
      key.keyElement.removeEventListener("touchstart", key.pressHandler);
      key.keyElement.removeEventListener("mouseup", key.releaseHandler);
      key.keyElement.removeEventListener("touchend", key.releaseHandler);
      key.keyElement.removeEventListener("mouseenter", key.enterHandler);
      key.keyElement.removeEventListener("mouseleave", key.leaveHandler);
    });
  }

  const painoFragment = document.createDocumentFragment();
  pianoElt.innerHTML = "";
  pianoElt.className = `piano piano--first-octave-${firstOctave} piano--octave-count-${octaveCount}`;

  const keys = Array.from({ length: octaveCount * 12 + 1 }, (_, index) => {
    const keyName = pianoKeys[index % pianoKeys.length];
    const noteDescriptor = `${keyName}${
      firstOctave + Math.floor(index / pianoKeys.length)
    }`;
    const frequency = noteFrequency(noteDescriptor);

    const keyElement = document.createElement("div");
    keyElement.className = "key";

    const handlePress = (e) => {
      if (e) {
        if (e.which !== 1 && e.which !== 0) return;
        e.preventDefault();
      }

      keyElement.classList.add("key--active");
      lastPlayedKeyName = keyName;
      clickHandlers.forEach((handler) =>
        handler(frequency, keyName, noteDescriptor)
      );
    };
    const handleRelease = (e) => {
      if (e) {
        if (e.which !== 1 && e.which !== 0) return;
        e.preventDefault();
      }

      keyElement.classList.remove("key--active");
    };

    const handleEnter = (e) => {
      if (e) {
        e.preventDefault();
      }

      if (mouseIsDown) {
        keyElement.classList.add("key--active");
        clickHandlers.forEach((handler) =>
          handler(frequency, keyName, noteDescriptor)
        );
      } else {
        keyElement.classList.add("key--hover");
      }
    };
    const handleLeave = (e) => {
      if (e) {
        e.preventDefault();
      }

      keyElement.classList.remove("key--hover");
      keyElement.classList.remove("key--active");
      return;
    };

    keyElement.addEventListener("mousedown", handlePress);
    keyElement.addEventListener("touchstart", handlePress);
    keyElement.addEventListener("mouseup", handleRelease);
    keyElement.addEventListener("touchend", handleRelease);
    keyElement.addEventListener("mouseenter", handleEnter);
    keyElement.addEventListener("mouseleave", handleLeave);

    painoFragment.append(keyElement);

    return {
      keyElement,
      noteDescriptor,
      keyName,
      frequency,
      pressHandler: handlePress,
      releaseHandler: handleRelease,
      enterHandler: handleEnter,
      leaveHandler: handleLeave,
    };
  });

  pianoElt.append(painoFragment);

  while (currentKeys.length) {
    currentKeys.pop();
  }
  currentKeys.push(...keys);
}

window.currentKeys = currentKeys;

const keyboardWhiteKeys = {
  Tab: "c3",
  KeyQ: "d3",
  KeyW: "e3",
  KeyE: "f3",
  KeyR: "g3",
  KeyT: "a3",
  KeyY: "b3",
  KeyU: "c4",
  KeyI: "d4",
  KeyO: "e4",
  KeyP: "f4",
  BracketLeft: "g4",
  BracketRight: "a4",
  Backslash: "b4",
};
const keyboardWhiteKeyCodes = Object.keys(keyboardWhiteKeys);

const keyboardBlackKeys = {
  Digit1: "c♯3",
  Digit2: "d♯3",
  Digit4: "f♯3",
  Digit5: "g♯3",
  Digit6: "a♯3",
  Digit8: "c♯4",
  Digit9: "d♯4",
  Minus: "f♯4",
  Equal: "g♯4",
  Backspace: "a♯4",
};
const keyboardBlackKeyCodes = Object.keys(keyboardBlackKeys);

document.body.addEventListener("keydown", (e) => {
  if (
    e.repeat ||
    (!keyboardWhiteKeyCodes.includes(e.code) &&
      !keyboardBlackKeyCodes.includes(e.code))
  ) {
    return;
  }

  e.preventDefault();

  const noteDescriptor = keyboardWhiteKeys[e.code] || keyboardBlackKeys[e.code];
  const key = currentKeys.find((key) => key.noteDescriptor === noteDescriptor);
  if (!key) return;

  key.pressHandler();
});
document.body.addEventListener("keyup", (e) => {
  if (
    e.repeat ||
    (!keyboardWhiteKeyCodes.includes(e.code) &&
      !keyboardBlackKeyCodes.includes(e.code))
  ) {
    return;
  }

  e.preventDefault();

  const noteDescriptor = keyboardWhiteKeys[e.code] || keyboardBlackKeys[e.code];
  const key = currentKeys.find((key) => key.noteDescriptor === noteDescriptor);
  if (!key) return;

  key.releaseHandler();
});
