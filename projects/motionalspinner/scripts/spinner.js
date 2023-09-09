import { willLandAt, frictionRequiredToLandAt, willBeAt } from "./mechanics.js";
import {
  initialiseCursorTracking,
  resetCursorSpeed,
  getY,
  cursorSpeed,
} from "./track-cursor.js";
import { threadRunner } from "./thread-runner.js";

const body = document.body;
const nameCards = [];
const spinThread = threadRunner.addThread("spinner-sim", {
  fps: 60,
  simulate: true,
});
const renderThread = threadRunner.addThread("spinner-render", {
  simulate: false,
});

spinThread.addTask(keepSpinning);
renderThread.addTask(updateDOM);

let checkboxContainer = null;
let spinnerStartSpeed = 0;
let spinnerStartPos = 0;
let spinnerSpeed = 0;
let spinnerPos = 0;
let cards = null;
let lastY = null;
let requestedFriction = null;
let frict = null;
let nameCount = null;
let spinnerElt = null;
let nameFilter = null;

function enableTrackMouse(event) {
  event.preventDefault();

  resetCursorSpeed(event);
  spinThread.pause();
  if (body.classList) {
    body.classList.add("grabbing");
  }
  spinnerSpeed = 0;
  lastY = getY(event);
  body.addEventListener("mousemove", trackMouse, !1);
  body.addEventListener("touchmove", trackMouse, !1);
}

function disableTrackMouse(event) {
  event.preventDefault();

  if (body.classList) {
    document.body.classList.remove("grabbing");
  }
  lastY = null;
  body.removeEventListener("mousemove", trackMouse, !1);
  body.removeEventListener("touchmove", trackMouse, !1);
}

function startSpinnerSpinning(event) {
  event.preventDefault();
  spinnerStartPos = spinnerPos;
  spinnerStartSpeed = spinnerSpeed = px2spd(cursorSpeed());

  const calculatedLandingSpot = willLandAt({
    initialPosition: spinnerStartPos,
    initialVelocity: spinnerStartSpeed,
    friction: requestedFriction,
  });

  const integerLandingSpot =
    spinnerSpeed > 0
      ? Math.ceil(calculatedLandingSpot)
      : Math.floor(calculatedLandingSpot);
  frict = frictionRequiredToLandAt({
    initialPosition: spinnerStartPos,
    initialVelocity: spinnerStartSpeed,
    finalLanding: integerLandingSpot,
  });

  disableTrackMouse(event);
  startSpinning();
}

function simulateSpin(frameNumber) {
  if (nameCards.length) {
    spinnerPos = willBeAt(frameNumber, {
      initialPosition: spinnerStartPos,
      initialVelocity: spinnerStartSpeed,
      friction: frict,
    });
  }
}

function keepSpinning({ frame }) {
  if (spinnerSpeed) {
    simulateSpin(frame);
  } else {
    spinThread.pause();
  }
}

function startSpinning() {
  spinThread.resetFrame();
  spinThread.play();
}

function updateDOM() {
  killFallenNames();
  buildNames();
  renderNames();
}

function trackMouse(event) {
  event.preventDefault();

  const n = getY(event);
  spinnerPos += px2spd(n - lastY);
  lastY = n;
  updateDOM();
}

function px2spd(px) {
  return (px / innerHeight) * nameCount;
}

function cardPosition({ index }) {
  return (spinnerPos + index) / nameCount;
}

function maxPos() {
  return nameCards.length
    ? Math.max(...nameCards.map((e) => cardPosition(e)))
    : null;
}

function maxIndex() {
  return nameCards.length
    ? Math.max(...nameCards.map(({ index }) => index))
    : null;
}

function minPos() {
  return nameCards.length
    ? Math.min(...nameCards.map((card) => cardPosition(card)))
    : null;
}

function minIndex() {
  return nameCards.length
    ? Math.min(...nameCards.map(({ index }) => index))
    : null;
}

function buildNames() {
  for (0 === nameCards.length && addName(!0); minPos() > 0; ) {
    addName(!1);
  }
  for (; maxPos() < (nameCount - 1) / nameCount; ) {
    addName(!0);
  }
  renderNames();
}

function killName(card) {
  const cardIndex = nameCards.indexOf(card);
  nameCards.splice(cardIndex, 1)[0];
  if (card.elt.parentNode) {
    card.elt.remove();
  }
}

function killFallenNames() {
  if (
    minPos() < -1 / nameCount ||
    maxPos() > (1 / nameCount) * (nameCount - 1)
  ) {
    nameCards.forEach((card) => {
      const cardIndex = cardPosition(card);
      if (-1 / nameCount >= cardIndex || cardIndex >= 1) {
        killName(card);
      }
    });
  }
}

function renderName({ elt, index }) {
  elt.style.transform = `translateY(${100 * (spinnerPos + index)}%)`;
}

function renderNames() {
  nameCards.forEach((card) => {
    renderName(card);
  });
}

function addName(cardName = false) {
  const filteredCards = nameFilter
    ? cards.filter(({ name }) => nameFilter.includes(name))
    : cards;
  const unusedCards = filteredCards.filter(({ name }) =>
    nameCards.every(({ text }) => text.name !== name)
  );

  const randomPerson =
    unusedCards[Math.floor(Math.random() * unusedCards.length)];
  const index =
    nameCards.length === 0 ? 0 : cardName ? maxIndex() + 1 : minIndex() - 1;

  const cardElt = document.createElement("div");
  cardElt.className = "name";

  const labelWrapperElt = document.createElement("p");
  labelWrapperElt.className = "name__text-wrapper";

  const labelElt = document.createElement("span");
  labelElt.className = "name__text";

  // I’m not sure why random person sometimes doensn’t exist
  if (randomPerson) {
    cardElt.style.setProperty(
      "--i-bg",
      randomPerson.image ? `url("../${randomPerson.image}")` : "none"
    );
    labelElt.innerHTML = (randomPerson && randomPerson.name) || "";
  }

  cardElt.append(labelWrapperElt);
  labelWrapperElt.append(labelElt);
  spinnerElt.append(cardElt);

  nameCards.push({ text: randomPerson, index: index, elt: cardElt });
}

function setNameCount(desiredNewCount) {
  nameCount = Math.min(15, desiredNewCount, Math.round(cards.length / 2));
}

export function initialiseSpinner(
  _spinnerElt,
  _cards,
  {
    friction = 0.01,
    desiredNameCount = 5,
    initialItemNames = _cards.map(({ name }) => name),
  } = {}
) {
  cards = _cards;
  spinnerElt = _spinnerElt;
  requestedFriction = friction;
  setNameCount(desiredNameCount);
  nameFilter = initialItemNames;

  buildNames();
  initialiseCursorTracking();

  body.addEventListener("mouseup", startSpinnerSpinning, !1);
  body.addEventListener("touchend", startSpinnerSpinning, !1);
  body.addEventListener("touchcancel", startSpinnerSpinning, !1);
  body.addEventListener("mousedown", enableTrackMouse, !1);
  body.addEventListener("touchstart", enableTrackMouse, !1);

  document.body.style.setProperty("--name-count", nameCount);

  checkboxContainer = createCheckboxControls();
}

function createCheckboxControls() {
  const togglesToggle = document.createElement("button");
  togglesToggle.className = "checkbox-toggle";
  togglesToggle.addEventListener("click", toggleCheckboxContainer);
  document.body.append(togglesToggle);

  const container = document.createElement("div");
  container.className = "checkbox-container";

  cards.forEach(({ name, image }) => {
    const checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.name = name;
    checkbox.value = name;
    checkbox.id = `spinner-checkbox-${name.replace(/\s+/g, "-")}`;
    checkbox.checked = nameFilter.includes(name);
    checkbox.addEventListener("change", (event) => {
      if (event.target.checked) {
        nameFilter.push(name);
      } else {
        nameFilter.splice(nameFilter.indexOf(name), 1);
      }
    });

    const label = document.createElement("label");
    const labelText = document.createTextNode(name);
    const img = new Image();
    img.src = image;
    label.setAttribute("for", `spinner-checkbox-${name.replace(/\s+/g, "-")}`);
    label.append(checkbox, img, labelText);

    container.appendChild(label);
  });

  return container;
}

function toggleCheckboxContainer() {
  if (document.body.contains(checkboxContainer)) {
    checkboxContainer.remove();
  } else {
    document.body.append(checkboxContainer);
  }
}
function handleKeyDown(event) {
  if (event.key !== "Escape") return;
  toggleCheckboxContainer();
}
window.addEventListener("keydown", handleKeyDown);
