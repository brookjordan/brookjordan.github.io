function HSLAString([ h, s, l, a = 1 ]) {
  return `hsla(${h},${s}%,${l}%,${a})`;
}

function nearestHue(hueFrom, hueTo = 360) {
  let newHue = hueFrom;
  while (newHue > hueTo + 180) {
    newHue -= 360;
  }
  while (newHue < hueTo - 180) {
    newHue += 360;
  }
  return newHue;
}

function bringCloser(from, to, amount = 0.5) {
  if (amount === 1) { return to; }
  if (amount === 0) { return from; }

  let multiplier = (1 / amount) - 1;
  return (from * multiplier + to) / (multiplier + 1);
}

function bringHueCloser(hueFrom, hueTo, amount = 0.5) {
  return bringCloser(nearestHue(hueFrom, hueTo), hueTo, amount);
}

function cleanHSLA([ h, s, l, a = 1 ]) {
  if (h < 0) {
    h += 360 * Math.ceil(Math.abs(h) / 360);
  }

  return [
    Math.round((h % 360) * 100) / 100,
    Math.round((Math.min(100, Math.max(0, s))) * 100) / 100,
    Math.round((Math.min(100, Math.max(0, l))) * 100) / 100,
    Math.round((Math.min(1, Math.max(0, a))) * 100) / 100,
  ];
}

function strictHSLA([ h, s, l, a = 1 ]) {
  [h, s, l, a] = cleanHSLA([h, s, l, a]);

  return [
    Math.round(h),
    Math.round(s),
    Math.round(l),
    Math.round(a),
  ];
}

function cleanRGBA([ r, g, b, a = 1 ]) {
  return [
    Math.min(255, Math.max(0, Math.round(r))),
    Math.min(255, Math.max(0, Math.round(g))),
    Math.min(255, Math.max(0, Math.round(b))),
    Math.min(1, Math.max(0, a)),
  ];
}

function RGBAToHSLA([ r, g, b, a = 1 ]) {
  let h = 0;

  r /= 255;
  g /= 255;
  b /= 255;

  let cmin = Math.min(r,g,b);
  let cmax = Math.max(r,g,b);
  let delta = cmax - cmin;

  // Calculate hue
  // No difference
  if (delta == 0) {
    h = 0;
  // Red is max
  } else if (cmax == r) {
    h = ((g - b) / delta) % 6;
  // Green is max
  } else if (cmax == g) {
    h = (b - r) / delta + 2;
  // Blue is max
  } else {
    h = (r - g) / delta + 4;
  }

  h = h * 60;

  let l = (cmax + cmin) / 2;

  // Calculate saturation
  let s = delta === 0 ? 0 : delta / (1 - Math.abs(2 * l - 1));

  // Multiply l and s by 100
  s = +(s * 100).toFixed(1);
  l = +(l * 100).toFixed(1);

  return [h, s, l, a];
}
