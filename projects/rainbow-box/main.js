const box = document.querySelector('.box');

let xx = -0.4;
let yy = 0.1;

let xRef = 0;
let yRef = 0;
let xRefPrev = 0;
let yRefPrev = 0;

let xPrev = xx * window.innerWidth;
let yPrev = yy * window.innerHeight;

const getTouch = e => e.touches && e.touches.length ? e.touches[e.touches.length - 1] : e;

const setVars = (x, y) => {
  const w = window.innerWidth;
  const h = window.innerHeight;
  const min = Math.min(w, h);

  xRefPrev = x;
  yRefPrev = y;

  xx = (xPrev + x - xRef) / min;
  yy = (yPrev + y - yRef) / min;
}

const handleMouseMove = e => {
  const touch = getTouch(e);
  setVars(touch.clientX, touch.clientY);
}

window.onmousedown = window.ontouchstart = e => {
  const touch = getTouch(e);

  xRef = touch.clientX;
  yRef = touch.clientY;
  setVars(touch.clientX, touch.clientY);

  window.onmousemove = handleMouseMove;
  window.ontouchmove = handleMouseMove;
}

window.onmouseup = window.onmouseleave = window.ontouchend = () => {
  xPrev += xRefPrev - xRef;
  yPrev += yRefPrev - yRef;

  window.onmousemove = () => {};
  window.ontouchmove = () => {};
}

const render = () => {
  box.style.setProperty('--x', xx);
  box.style.setProperty('--y', yy);
  requestAnimationFrame(render);
}
render();
