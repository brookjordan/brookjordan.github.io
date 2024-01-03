import { average } from "./math.js";

const cursorSpeeds = [];
const _document = document;
const body = _document.body;
let prevClientY = undefined;
let clientY = undefined;
let clientX = undefined;

export function initialiseCursorTracking() {
  body.addEventListener("mousemove", mouseSpeed, false);
  body.addEventListener("touchmove", mouseSpeed, false);
  body.addEventListener("touchstart", mouseSpeed, false);
  body.addEventListener("touchend", mouseSpeed, false);
  checkCursorSpeed();
}

export function getY(event) {
  let t = undefined;
  return (t = event.touches ? event.touches[0].pageY : event.clientY);
}

export function getX(event) {
  let t = undefined;
  return (t = event.touches ? event.touches[0].pageX : event.clientX);
}

export function resetCursorSpeed(event) {
  for (; cursorSpeeds.length; ) cursorSpeeds.pop();
  clientY = prevClientY = getY(event);
}

export function cursorSpeed() {
  return average.apply(undefined, cursorSpeeds);
}

function checkCursorSpeed() {
  addMousePositionToStack(), requestAnimationFrame(checkCursorSpeed);
}

function addMousePositionToStack() {
  if ("number" == typeof clientY) {
    "number" == typeof prevClientY || (prevClientY = clientY);
    cursorSpeeds.push(clientY - prevClientY);
    cursorSpeeds.length > 5 && cursorSpeeds.unshift();
    prevClientY = clientY;
  }
}

function mouseSpeed(e) {
  clientY = getY(e);
  clientX = getX(e);
}
