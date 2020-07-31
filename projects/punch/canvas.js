const canvas = document.querySelector("#game");
const ctx = canvas.getContext('2d');
export const board = {
  ctx,
  fillRect,
  clear,
};

resizeCanvas();

function resizeCanvas() {
  canvas.width
    = board.pixelWidth
    = canvas.height
    = board.pixelHeight
    = canvas.clientWidth * devicePixelRatio;

  console.log(`Resized canvas to ${board.pixelWidth} x ${board.pixelHeight}`);
}

function perc(percentage) {
  return Math.round(board.pixelWidth / 100 * percentage);
}

function fillRect(x, y, dx, dy, color) {
  color && (ctx.fillStyle = color);
  ctx.fillRect(perc(x), perc(y), perc(dx), perc(dy));
}

function clear() {
  ctx.clearRect(0, 0, board.pixelWidth, board.pixelHeight);
}
