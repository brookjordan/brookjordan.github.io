import {
  cube,
} from './parts.js';

let x = 0;
let y = 0;
let speedX = 0;
let speedY = 0;

let cubeRAF = false;
let siminitX = 0;
let simInitY = 0;
let simX = 0;
let simY = 0;

window.addEventListener('mousedown', startControl);
window.addEventListener('mouseup', stopControl);
window.addEventListener('mouseleave', stopControl);

function simCube() {
  cubeRAF = requestAnimationFrame(simCube);

  // Friction
  speedX *= 0.9;
  speedY *= 0.9;

  // Apply speed
  x += speedX;
  y += speedY;

  // Apply new position
  cube.rotation.x = y / 100;
  cube.rotation.y = x / 100;
}

function startControl(event) {
  cancelAnimationFrame(cubeRAF);

  const touch = event.touches ? event.touches[0] : event;

  siminitX = touch.clientX;
  simInitY = touch.clientY;

  window.addEventListener('mousemove', updatePos);
}

function stopControl(event) {
  const touch = event.touches ? event.touches[0] : event;

  x += touch.clientX - siminitX;
  y += touch.clientY - simInitY;

  window.removeEventListener('mousemove', updatePos);

  cubeRAF = requestAnimationFrame(simCube);
}

function updatePos(event) {
  const touch = event.touches ? event.touches[0] : event;

  let prevSimX = simX;
  let prevSimY = simY;

  simX = x + touch.clientX - siminitX;
  simY = y + touch.clientY - simInitY;

  cube.rotation.x = simY / 100;
  cube.rotation.y = simX / 100;

  speedX = (speedX + (simX - prevSimX)) / 2;
  speedY = (speedY + (simY - prevSimY)) / 2;
}
