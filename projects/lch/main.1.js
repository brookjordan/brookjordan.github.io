import * as colors from "./colors.1.js";

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

drawCross(+range.value);
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

find_hex.oninput = e => {
  if (!find_hex.checkValidity()) { return; }
  let hexNum = find_hex.value.replace(/#/, '');
  if (hexNum.length < 4) {
    hexNum = hexNum.replace(/./g, a => `${a}${a}`);
  }
  let rgb = Array.from({ length: 3 }, (_, i) => parseInt(hexNum.slice(i * 2, i * 2 + 2), 16));
  let rgbD = rgb.map(a => a / 255);

  let lch = Lab_to_LCH(XYZ_to_Lab(D65_to_D50(lin_2020_to_XYZ(lin_2020(rgbD)))));
  range.value = lch[0];
  // max_chroma.value = lch[1];
  // MAX_CHROMA = +max_chroma.value;
  drawCross(+range.value);
};
find_hex.oninput();
