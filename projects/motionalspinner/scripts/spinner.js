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
});
const renderThread = threadRunner.addThread("spinner-render", {
  fps: 60,
});
spinThread.addTask(keepSpinning);
renderThread.addTask(updateDOM);

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
let container = null;

function enableTrackMouse(e) {
  e.preventDefault();
  resetCursorSpeed(e);
  spinThread.pause();
  body.classList && body.classList.add("grabbing");
  spinnerSpeed = 0;
  lastY = getY(e);
  body.addEventListener("mousemove", trackMouse, !1);
  body.addEventListener("touchmove", trackMouse, !1);
}

function disableTrackMouse(e) {
  e.preventDefault();
  body.classList && document.body.classList.remove("grabbing");
  lastY = null;
  body.removeEventListener("mousemove", trackMouse, !1);
  body.removeEventListener("touchmove", trackMouse, !1);
}

function startSpinnerSpinning(e) {
  e.preventDefault();
  spinnerStartPos = spinnerPos;
  spinnerStartSpeed = spinnerSpeed = px2spd(cursorSpeed());

  const n = willLandAt({
    initialPosition: spinnerStartPos,
    initialVelocity: spinnerStartSpeed,
    friction: requestedFriction,
  });

  const r = spinnerSpeed > 0 ? Math.ceil(n) : Math.floor(n);
  (frict = frictionRequiredToLandAt({
    initialPosition: spinnerStartPos,
    initialVelocity: spinnerStartSpeed,
    finalLanding: r,
  })),
    disableTrackMouse(e),
    startSpinning();
}

function simulateSpin(e) {
  if (nameCards.length) {
    spinnerPos = willBeAt(e, {
      initialPosition: spinnerStartPos,
      initialVelocity: spinnerStartSpeed,
      friction: frict,
    });
  }
}

function keepSpinning() {
  if (spinnerSpeed) {
    simulateSpin(this.frame);
  } else {
    spinThread.pause();
  }
}

function startSpinning() {
  spinThread.resetFrame(), spinThread.play();
}

function updateDOM() {
  killNames(), buildNames(), renderNames();
}

function trackMouse(e) {
  e.preventDefault();
  const n = getY(e);
  (spinnerPos += px2spd(n - lastY)), (lastY = n), updateDOM();
}

function px2spd(e) {
  return (e / innerHeight) * nameCount;
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
    ? Math.min(...nameCards.map((e) => cardPosition(e)))
    : null;
}

function minIndex() {
  return nameCards.length
    ? Math.min(...nameCards.map(({ index }) => index))
    : null;
}

function buildNames() {
  for (0 === nameCards.length && addName(!0); minPos() > 0; ) addName(!1);
  for (; maxPos() < (nameCount - 1) / nameCount; ) addName(!0);
  renderNames();
}

function killName(e) {
  const n = nameCards.indexOf(e);
  nameCards.splice(n, 1)[0];
  e.elt.parentNode && e.elt.parentNode.removeChild(e.elt);
}

function killNames() {
  (minPos() < -1 / nameCount || maxPos() > (1 / nameCount) * (nameCount - 1)) &&
    nameCards.forEach((e, n) => {
      const r = cardPosition(e);
      -1 / nameCount >= r && killName(e), r >= 1 && killName(e);
    });
}

function renderName({ elt, index }) {
  elt.style.transform = `translateY(${100 * (spinnerPos + index)}%)`;
}

function renderNames() {
  nameCards.forEach((e) => {
    renderName(e);
  });
}

function addName(e) {
  const filteredCards = nameFilter
    ? cards.filter(({ name }) => nameFilter.includes(name))
    : cards;
  const unusedCards = filteredCards.filter(({ name }) =>
    nameCards.every(({ text }) => text.name !== name)
  );
  const n = e || false;
  const cardElt = document.createElement("div");
  const labelElt = document.createElement("p");
  const cardHeight = 100 / nameCount;
  const randomPerson =
    unusedCards[Math.floor(Math.random() * unusedCards.length)];
  const s = 0 === nameCards.length ? 0 : n ? maxIndex() + 1 : minIndex() - 1;
  cardElt.className = "name";
  cardElt.style.height = `${cardHeight}vh`;
  cardElt.style.lineHeight = `${cardHeight}vh`;
  if (randomPerson.image) {
    const imageStyle = `url("${randomPerson.image}")`;
    cardElt.style.backgroundImage = imageStyle;
  } else {
    cardElt.style.backgroundImage = "none";
  }
  labelElt.innerHTML = randomPerson ? randomPerson.name || "" : "";
  labelElt.className = "name__text";
  labelElt.style.fontSize = `${Math.min(6, 40 / nameCount)}vmin`;
  cardElt.appendChild(labelElt);
  spinnerElt.appendChild(cardElt);
  nameCards.push({ text: randomPerson, index: s, elt: cardElt });
}

export function spinner(e, items, options = {}) {
  const t = options.desiredNameCount;
  const a = null === t ? 4 : t;
  const i = options.friction;
  const s = null === i ? 0.01 : i;

  cards = items;
  spinnerElt = e;
  requestedFriction = s;
  nameCount = Math.min(a, Math.round(cards.length / 2));

  if (options.filterItemNames) {
    nameFilter = options.filterItemNames;
  }

  buildNames();
  initialiseCursorTracking();

  body.addEventListener("mouseup", startSpinnerSpinning, !1);
  body.addEventListener("touchend", startSpinnerSpinning, !1);
  body.addEventListener("touchcancel", startSpinnerSpinning, !1);
  body.addEventListener("mousedown", enableTrackMouse, !1);
  body.addEventListener("touchstart", enableTrackMouse, !1);
}

function handleEscPressOpen(e) {
  if (e.key !== "Escape") return;

  makeNameCheckboxes();
  window.removeEventListener("keypress", handleEscPressOpen);
  window.addEventListener("keypress", handleEscPressClose);
}
function handleEscPressClose(e) {
  if (e.key !== "Escape") return;

  killNameCheckboxes();
  window.removeEventListener("keypress", handleEscPressClose);
  window.addEventListener("keypress", handleEscPressOpen);
}
window.addEventListener("keypress", handleEscPressOpen);

function killNameCheckboxes() {
  container.remove();
}

function makeNameCheckboxes() {
  container = document.createElement("div");
  cards.forEach(({ name }) => {
    const checkbox = document.createElement("input");
    const label = document.createElement("label");
    checkbox.type = "checkbox";
    checkbox.name = name;
    checkbox.value = name;
    checkbox.id = `spinner-checkbox-${name.replace(/\s+/g, "-")}`;
    checkbox.checked = nameFilter.includes(name);
    checkbox.addEventListener("change", (e) => {
      if (e.target.checked) {
        nameFilter.push(name);
      } else {
        nameFilter.splice(nameFilter.indexOf(name), 1);
      }
    });
    label.textContent = name;
    label.setAttribute("for", `spinner-checkbox-${name.replace(/\s+/g, "-")}`);
    container.appendChild(checkbox);
    container.appendChild(label);
  });
  document.body.appendChild(container);
  container.style.cssText = `
    font-size: 22px;
    font-family: "Nunito Sans", "open sans", sans-serif;
    position: fixed;
    z-index: 1000;
    background: white;
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 15px 30px;
    padding: 20px;
    overflow-y: auto;
    height: 100vh;
    width: 100vw;
    box-sizing: border-box;
    justify-content: center;
    cursor: default !important;
  `;
}
