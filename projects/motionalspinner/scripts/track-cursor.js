import { average } from "./math.js";

const cursorSpeeds = [];
const _document = document;
const body = _document.body;
let prevClientY = void 0;
let clientY = void 0;
let clientX = void 0;

export function initialiseCursorTracking() {
  body.addEventListener("mousemove", mouseSpeed, !1),
    body.addEventListener("touchmove", mouseSpeed, !1),
    body.addEventListener("touchstart", mouseSpeed, !1),
    body.addEventListener("touchend", mouseSpeed, !1),
    checkCursorSpeed();
}

export function getY(e) {
  let t = void 0;
  return (t = e.touches ? e.touches[0].pageY : e.clientY);
}

export function getX(e) {
  let t = void 0;
  return (t = e.touches ? e.touches[0].pageX : e.clientX);
}

export function resetCursorSpeed(e) {
  for (; cursorSpeeds.length; ) cursorSpeeds.pop();
  clientY = prevClientY = getY(e);
}

export function cursorSpeed() {
  return average.apply(void 0, cursorSpeeds);
}

function checkCursorSpeed() {
  addMousePositionToStack(), requestAnimationFrame(checkCursorSpeed);
}

function addMousePositionToStack() {
  "number" == typeof clientY &&
    ("number" == typeof prevClientY || (prevClientY = clientY),
    cursorSpeeds.push(clientY - prevClientY),
    cursorSpeeds.length > 5 && cursorSpeeds.unshift(),
    (prevClientY = clientY));
}

function mouseSpeed(e) {
  (clientY = getY(e)), (clientX = getX(e));
}
