export function refreshSize(board) {
  let cloneCanvas = document.createElement("canvas");
  let cloneCtx = cloneCanvas.getContext("2d");
  cloneCtx.drawImage(board.ctx.canvas, 0, 0);

  let size = board.display;
  board.ctx.canvas.width = size.width;
  board.ctx.canvas.height = size.height;
  board.ctx.drawImage(cloneCanvas, 0, 0, size.width, size.height);
}

export function fillRect(board, x, y, width, height, {
  color
} = {}) {
  if (color) {
    board.ctx.fillStyle = color;
    debugger;
  }
  board.ctx.fillRect(plotXOn(x, board.ctx.canvas), plotYOn(y, board.ctx.canvas), plotXOn(width, board.ctx.canvas), plotYOn(height, board.ctx.canvas));
}

export function plotXOn(x, canvas) {
  return x / 100 * canvas.width;
}

export function plotYOn(y, canvas) {
  return y / 100 * canvas.height;
}
