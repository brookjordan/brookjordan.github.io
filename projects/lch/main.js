import * as colors from "./colors.js";

let raf;
let lastFrameDrawnAt = 0;

quality.max = Math.ceil(Math.min(Math.round(innerWidth / 2), Math.round(innerHeight / 2), 500) / 25) * 25;
let thickness = +quality.value;
let size = thickness * 2 + 1;
canvas.width = canvas.height = size;

let clipOpacity = +clip_opacity.value;

let MAX_CHROMA = +max_chroma.value;
let ctx = canvas.getContext("2d");

function drawBlock(color, x, y) {
  ctx.fillStyle = color;
  ctx.fillRect(x, y, 1, 1);
}

function shg(x, y) {
  return Math.atan2(x, y) / Math.PI * 180;
}

function xyAngle(x, y) {
  return Math.atan2(x, y) / Math.PI * 180;
}

function drawCross(lightness) {
  cancelAnimationFrame(raf);

  function drawRow(y) {
    ctx.clearRect(0, y, size, 1);
    for (let x = 0; x < size; x += 1) {
      let xx = x - thickness;
      let yy = y - thickness;
      let angle = xyAngle(xx, yy);

      let color = colors.LCH_to_sRGB_string([
        lightness,
        (MAX_CHROMA / (thickness + 1)) * (Math.sqrt(xx * xx + yy * yy)),
        angle
      ], clipOpacity);
      if (color) {
        drawBlock(
          color,
          x,
          y
        );
      }
    }

    if (y < size) {
      let timeNow = new Date().getTime();
      if (lastFrameDrawnAt < timeNow - 1000 / 15) {
        lastFrameDrawnAt = timeNow;
        raf = requestAnimationFrame(() => {
          drawRow(y + 1);
        });
      } else {
        drawRow(y + 1);
      }
    }
  }

  raf = requestAnimationFrame(() => {
    drawRow(0);
  });
}

drawCross(50);
range.oninput = e => drawCross(+range.value);
max_chroma.oninput = e => {
  MAX_CHROMA = +max_chroma.value;
  drawCross(+range.value)
};
clip_opacity.oninput = e => {
  clipOpacity = +clip_opacity.value;
  drawCross(+range.value)
};
quality.oninput = e => {
  thickness = +quality.value;
  size = thickness * 2 + 1;
  canvas.width = canvas.height = size;
  drawCross(+range.value)
};
