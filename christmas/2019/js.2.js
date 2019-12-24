const WIDTH_RATIO = 340;
const HEIGHT_RATIO = 200;
const ASPECT_RATIO = WIDTH_RATIO / HEIGHT_RATIO;

const CANVAS_ELT = document.querySelector('.canvas');

function resizeCanvas() {
  let width = innerWidth;
  let height = innerHeight;
  let ratio = innerWidth / innerHeight;

  let canvasWidth;
  let canvasHeight;

  if (ratio > ASPECT_RATIO) {
    canvasWidth = height * ASPECT_RATIO;
    canvasHeight = height;
  } else {
    canvasWidth = width;
    canvasHeight = width / ASPECT_RATIO;
  }

  CANVAS_ELT.style.height = `${canvasHeight}px`;
  CANVAS_ELT.style.width = `${canvasWidth}px`;
  CANVAS_ELT.style.setProperty('--h-font-size', `calc(${canvasWidth * 0.02}px * var(--font-size))`);
}

resizeCanvas();

window.addEventListener('resize', resizeCanvas);
window.addEventListener('orientationchange', resizeCanvas);
