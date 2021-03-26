let renderRAF;
let lastFrameDrawnAt = 0;

quality.max = Math.ceil(Math.min(Math.round(innerWidth / 2), Math.round(innerHeight / 2), 500) / 25) * 25;
let thickness = +quality.value;
let size = thickness * 2 + 1;
canvas.width = canvas.height = size;

let clipOpacity = +clip_opacity.value;

let MAX_CHROMA = +max_chroma.value;
let ctx = canvas.getContext("2d");

let chroma = 0;
let hue = 0;

function drawBlock(color, x, y) {
  ctx.fillStyle = color;
  ctx.fillRect(x, y, 1, 1);
}

function xyAngle(x, y) {
  return (Math.atan2(x, y) / Math.PI * 180 + 360) % 360;
}

function render(lightness) {
  console.log(lightness);
  cancelAnimationFrame(renderRAF);

  function renderRow(y) {
    ctx.clearRect(0, y, size, 1);
    for (let x = 0; x < size; x += 1) {
      let xx = x - thickness;
      let yy = y - thickness;
      let angle = xyAngle(xx, yy);

      let lch = [
        lightness,
        (MAX_CHROMA / (thickness + 1)) * (Math.sqrt(xx * xx + yy * yy)),
        angle,
      ];

      let color;
      let colorObject = new Color({color: lch, type: 'lchab'});
      let rgb = colorObject.rgb;
      let rgbClipped = rgb.map(c => Math.max(0, Math.min(255, c)));

      if(
        rgb[0] >= 0 && rgb[0] <= 255
        && rgb[1] >= 0 && rgb[1] <= 255
        && rgb[2] >= 0 && rgb[2] <= 255
      ) {
        color = `rgb(${rgbClipped})`;
      } else if (clipOpacity > 0) {
        color = `rgba(${rgbClipped},${clipOpacity / 100})`;
      }

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
        renderRAF = requestAnimationFrame(() => {
          renderRow(y + 1);
        });
      } else {
        renderRow(y + 1);
      }
    }
  }

  renderRAF = requestAnimationFrame(() => {
    renderRow(0);
  });
}

render(+range.value);
range.oninput = e => {
  find_hex.value = new Color({ color: [+range.value, chroma, hue], type: 'lchab' }).hex;
  render(+range.value)
};
max_chroma.oninput = e => {
  MAX_CHROMA = +max_chroma.value;
  render(+range.value)
};
clip_opacity.oninput = e => {
  clipOpacity = +clip_opacity.value;
  render(+range.value)
};
quality.oninput = e => {
  thickness = +quality.value;
  size = thickness * 2 + 1;
  canvas.width = canvas.height = size;
  render(+range.value)
};

find_hex.oninput = e => {
  if (!find_hex.checkValidity()) { return; }
  let hexNum = find_hex.value.replace(/#/, '');
  if (hexNum.length < 4) {
    hexNum = hexNum.replace(/./g, a => `${a}${a}`);
  }
  let rgb = Array.from({ length: 3 }, (_, i) => parseInt(hexNum.slice(i * 2, i * 2 + 2), 16));

  // let rgbD = rgb.map(a => a / 255);
  // let lch = Lab_to_LCH(XYZ_to_Lab(D65_to_D50(lin_2020_to_XYZ(lin_2020(rgbD)))));

  let lch = new Color({ color: rgb, type: 'rgb' }).lchab;
  range.value = lch[0];
  chroma = lch[1];
  hue = lch[2];
  let style = `translate(-50%, -50%) rotate(${-hue + 180}deg) translateY(${-chroma / (MAX_CHROMA / 100)}%)`;
  cursor.style.transform = style;

  // max_chroma.value = lch[1];
  // MAX_CHROMA = +max_chroma.value;

  render(+range.value);
};
// find_hex.oninput();
