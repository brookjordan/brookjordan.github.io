function cleanManipulator(func) {
  return function manipulateCleanly(hsla) {
    return cleanHSLA(func(...cleanHSLA(hsla)));
  };
}

let colourManupulators = {
  standard: cleanManipulator((h, s, l, a) => { // Bright; vivid
    return [h, s, l, a];
  }),

  ablaze: cleanManipulator((h, s, l, a) => { // Radiant with bright color
    h = bringHueCloser(h, 18, 1/3);

    if (s !== 0) {
      s = bringCloser(s, 100, 1/3);
    }

    return [h, s, l, a];
  }),

  analagous: cleanManipulator((h, s, l, a) => { // 30 degress past
    h += 30;

    return [h, s, l, a];
  }),

  analagous2: cleanManipulator((h, s, l, a) => { // 30 degress past
    h -= 30;

    return [h, s, l, a];
  }),

  beaming: cleanManipulator((h, s, l, a) => { // Bright; shining
    h = bringHueCloser(h, 60, 1/5);

    if (s !== 0) {
      s = bringCloser(s, 100, 1/5);
    }

    l = bringCloser(l, 98, 1/2);

    return [h, s, l, a];
  }),

  bold: cleanManipulator((h, s, l, a) => { // Bright; vivid
    s = bringCloser(s, 100, 1/2);

    l = bringCloser(l, 50, 1/2);

    return [h, s, l, a];
  }),

  bright: cleanManipulator((h, s, l, a) => { // Brilliant in color
    s = bringCloser(s, 100, 3/4);

    l = bringCloser(l, 80, 1/2);

    return [h, s, l, a];
  }),

  brilliant: cleanManipulator((h, s, l, a) => { // Vivid; intense
    return [h, s, l, a];
  }),

  colorful: cleanManipulator((h, s, l, a) => { // Full of vivid colors
    return [h, s, l, a];
  }),

  compliment: cleanManipulator((h, s, l, a) => { // 30 degress past
    h += 180;

    return [h, s, l, a];
  }),

  dappled: cleanManipulator((h, s, l, a) => { // Having a spotted surface
    return [h, s, l, a];
  }),

  deep: cleanManipulator((h, s, l, a) => { // Dark; rich
    return [h, s, l, a];
  }),

  delicate: cleanManipulator((h, s, l, a) => { // Subtle; slight
    return [h, s, l, a];
  }),

  electric: cleanManipulator((h, s, l, a) => { // Bright; metallic
    return [h, s, l, a];
  }),

  festive: cleanManipulator((h, s, l, a) => { // Celebratory; merry
    return [h, s, l, a];
  }),

  fiery: cleanManipulator((h, s, l, a) => { // Burning or glowing like fire
    return [h, s, l, a];
  }),

  flamboyant: cleanManipulator((h, s, l, a) => { // Extravagant; exuberant
    return [h, s, l, a];
  }),

  flaming: cleanManipulator((h, s, l, a) => { // Resembling a flame or fire
    return [h, s, l, a];
  }),

  fresh: cleanManipulator((h, s, l, a) => { // Recent; new
    return [h, s, l, a];
  }),

  gaudy: cleanManipulator((h, s, l, a) => { // showy; too flashy
    if (s !== 0) {
      s = 100;
    }

    l = 50;

    return [h, s, l, a];
  }),

  glistening: cleanManipulator((h, s, l, a) => { // Sparkling or shining like glitter
    return [h, s, l, a];
  }),

  glowing: cleanManipulator((h, s, l, a) => { // Producing light or warmth
    return [h, s, l, a];
  }),

  iridescent: cleanManipulator((h, s, l, a) => { // Something with rainbow-like colors
    return [h, s, l, a];
  }),

  jazzy: cleanManipulator((h, s, l, a) => { // Lively; bright
    return [h, s, l, a];
  }),

  opalescent: cleanManipulator((h, s, l, a) => { // Having a milky iridescence like an opal
    return [h, s, l, a];
  }),

  prismatic: cleanManipulator((h, s, l, a) => { // Multi-colored; brilliant; bright
    return [h, s, l, a];
  }),

  radiant: cleanManipulator((h, s, l, a) => { // Glowing; bright
    return [h, s, l, a];
  }),

  sepia: cleanManipulator((h, s, l, a) => { // A reddish/brown color, like old photographs
    return [h, s, l, a];
  }),

  vibrant: cleanManipulator((h, s, l, a) => { // Full of color
    return [h, s, l, a];
  }),

  vivid: cleanManipulator((h, s, l, a) => { // Bright, intense colors
    return [h, s, l, a];
  }),

  ashy: cleanManipulator((h, s, l, a) => { // Having the color of ash; pale
    return [h, s, l, a];
  }),

  bleak: cleanManipulator((h, s, l, a) => { // Gloomy; somber; not colorful
    return [h, s, l, a];
  }),

  blotchy: cleanManipulator((h, s, l, a) => { // Discolored or patchy
    return [h, s, l, a];
  }),

  brash: cleanManipulator((h, s, l, a) => { // Abrasive; tacky
    return [h, s, l, a];
  }),

  chintzy: cleanManipulator((h, s, l, a) => { // Cheap-looking
    return [h, s, l, a];
  }),

  cold: cleanManipulator((h, s, l, a) => { // Depressing; saddening
    return [h, s, l, a];
  }),

  colorless: cleanManipulator((h, s, l, a) => { // Lacking color; dull
    return [h, s, l, a];
  }),

  dark: cleanManipulator((h, s, l, a) => { // Lacking in light
    return [h, s, l, a];
  }),

  dim: cleanManipulator((h, s, l, a) => { // Not bright
    return [h, s, l, a];
  }),

  discolored: cleanManipulator((h, s, l, a) => { // Deprived of color; given the wrong color
    return [h, s, l, a];
  }),

  drab: cleanManipulator((h, s, l, a) => { // A dull, yellowish-brown color
    return [h, s, l, a];
  }),

  harsh: cleanManipulator((h, s, l, a) => { // Disagreeable; unpleasant
    return [h, s, l, a];
  }),

  loud: cleanManipulator((h, s, l, a) => { // Overly intense
    return [h, s, l, a];
  }),

  muddy: cleanManipulator((h, s, l, a) => { // Not clear
    return [h, s, l, a];
  }),

  opaque: cleanManipulator((h, s, l, a) => { // Incapable of allowing light to pass through
    a = 1;

    return [h, s, l, a];
  }),

  saturated: cleanManipulator((h, s, l, a) => { // Overfly full
    if (s !== 0) {
      s = 100;
    }

    return [h, s, l, a];
  }),

  sickly: cleanManipulator((h, s, l, a) => { // Having a pallor that reflects being nauseated
    return [h, s, l, a];
  }),

  somber: cleanManipulator((h, s, l, a) => { // Dark; gloomy; dull
    return [h, s, l, a];
  }),

  sooty: cleanManipulator((h, s, l, a) => { // Black or dusky in color
    return [h, s, l, a];
  }),

  splashy: cleanManipulator((h, s, l, a) => { // Attracting too much attention
    return [h, s, l, a];
  }),

  stained: cleanManipulator((h, s, l, a) => { // An unwanted spot
    return [h, s, l, a];
  }),

  uneven: cleanManipulator((h, s, l, a) => { // Not smooth; irregular
    return [h, s, l, a];
  }),

  washedout: cleanManipulator((h, s, l, a) => { // Lacking color; faded
    return [h, s, l, a];
  }),

  watery: cleanManipulator((h, s, l, a) => { // Containing too much water; diluted
    return [h, s, l, a];
  }),

  colorless: cleanManipulator((h, s, l, a) => { // Dull or lacking in color
    return [h, s, l, a];
  }),

  dotted: cleanManipulator((h, s, l, a) => { // A series of small spots or marks
    return [h, s, l, a];
  }),

  faded: cleanManipulator((h, s, l, a) => { // Less bright
    return [h, s, l, a];
  }),

  flecked: cleanManipulator((h, s, l, a) => { // Having a spot or small patch of color
    return [h, s, l, a];
  }),

  light: cleanManipulator((h, s, l, a) => { // Lacking brightness or saturation
    return [h, s, l, a];
  }),

  monochromatic: cleanManipulator((h, s, l, a) => { // Having one color
    return [h, s, l, a];
  }),

  monotone: cleanManipulator((h, s, l, a) => { // All one color
    return [h, s, l, a];
  }),

  muted: cleanManipulator((h, s, l, a) => { // Subdued or softened colors
    return [h, s, l, a];
  }),

  neutral: cleanManipulator((h, s, l, a) => { // Having very little color
    return [h, s, l, a];
  }),

  pale: cleanManipulator((h, s, l, a) => { // Something light in color or washed out
    return [h, s, l, a];
  }),

  primary: cleanManipulator((h, s, l, a) => { // Basic color
    return [h, s, l, a];
  }),

  rustic: cleanManipulator((h, s, l, a) => { // Plain; simple
      h = bringHueCloser(h, 20, 1/3);

      if (s !== 0) {
        s = bringCloser(s, 15, 1/3);
      }

    return [h, s, l, a];
  }),

  tinged: cleanManipulator((h, s, l, a) => { // A small amount of color
      s = (s + 30) / 2;

    return [h, s, l, a];
  }),

  tinted: cleanManipulator((h, s, l, a) => { // Slightly colored
    s = (s + 15) / 2;

    return cleanHSLA([h, s, l, a]);
  }),

  translucent: cleanManipulator((h, s, l, a) => { // Allowing light to pass through
    a = (a + 0.5) / 2;

    return cleanHSLA([h, s, l, a]);
  }),

  transparent: cleanManipulator((h, s, l, a) => { // Clear; see-through
    a = 0;

    return hsla;
  }),
};
