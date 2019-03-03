/*
  Vibrant.js
  by Jari Zwarts

  Color algorithm class that finds variations on colors in an image.

  Credits
  --------
  Lokesh Dhakar (http://www.lokeshdhakar.com) - Created ColorThief
  Google - Palette support library in Android
*/

import CanvasImage from '../vendor/canvas-image.js';
import Swatch from '../vendor/swatch.js';
import Quantize from '../vendor/quantize.js';


class Vibrant {
  static initClass() {

    this.prototype.quantize = Quantize;

    this.prototype._swatches = [];

    this.prototype.TARGET_DARK_LUMA = 0.26;
    this.prototype.MAX_DARK_LUMA = 0.45;
    this.prototype.MIN_LIGHT_LUMA = 0.55;
    this.prototype.TARGET_LIGHT_LUMA = 0.74;

    this.prototype.MIN_NORMAL_LUMA = 0.3;
    this.prototype.TARGET_NORMAL_LUMA = 0.5;
    this.prototype.MAX_NORMAL_LUMA = 0.7;

    this.prototype.TARGET_MUTED_SATURATION = 0.3;
    this.prototype.MAX_MUTED_SATURATION = 0.4;

    this.prototype.TARGET_VIBRANT_SATURATION = 1;
    this.prototype.MIN_VIBRANT_SATURATION = 0.35;

    this.prototype.WEIGHT_SATURATION = 3;
    this.prototype.WEIGHT_LUMA = 6;
    this.prototype.WEIGHT_POPULATION = 1;

    this.prototype.VibrantSwatch = undefined;
    this.prototype.MutedSwatch = undefined;
    this.prototype.DarkVibrantSwatch = undefined;
    this.prototype.DarkMutedSwatch = undefined;
    this.prototype.LightVibrantSwatch = undefined;
    this.prototype.LightMutedSwatch = undefined;

    this.prototype.HighestPopulation = 0;
  }

  constructor(sourceImage, colorCount, quality) {
    this.swatches = this.swatches.bind(this);
    if (typeof colorCount === 'undefined') {
      colorCount = 64;
    }
    if (typeof quality === 'undefined') {
      quality = 5;
    }

    const image = new CanvasImage(sourceImage);
    try {
      const imageData = image.getImageData();
      const pixels = imageData.data;
      const pixelCount = image.getPixelCount();

      const allPixels = [];
      let i = 0;
      while (i < pixelCount) {
        const offset = i * 4;
        const r = pixels[offset + 0];
        const g = pixels[offset + 1];
        const b = pixels[offset + 2];
        const a = pixels[offset + 3];
        // If pixel is mostly opaque and not white
        if (a >= 125) {
          if (!((r > 250) && (g > 250) && (b > 250))) {
            allPixels.push([r, g, b]);
          }
        }
        i = i + quality;
      }

      const cmap = this.quantize(allPixels, colorCount);
      this._swatches = cmap.vboxes.map(vbox => {
        return new Swatch(vbox.color, vbox.vbox.count());
      });

      this.maxPopulation = this.findMaxPopulation;

      this.generateVarationColors();
      this.generateEmptySwatches();

    // Clean up
    } finally {
      image.removeCanvas();
    }
  }

  generateVarationColors() {
    this.VibrantSwatch = this.findColorVariation(this.TARGET_NORMAL_LUMA, this.MIN_NORMAL_LUMA, this.MAX_NORMAL_LUMA,
      this.TARGET_VIBRANT_SATURATION, this.MIN_VIBRANT_SATURATION, 1);

    this.LightVibrantSwatch = this.findColorVariation(this.TARGET_LIGHT_LUMA, this.MIN_LIGHT_LUMA, 1,
      this.TARGET_VIBRANT_SATURATION, this.MIN_VIBRANT_SATURATION, 1);

    this.DarkVibrantSwatch = this.findColorVariation(this.TARGET_DARK_LUMA, 0, this.MAX_DARK_LUMA,
      this.TARGET_VIBRANT_SATURATION, this.MIN_VIBRANT_SATURATION, 1);

    this.MutedSwatch = this.findColorVariation(this.TARGET_NORMAL_LUMA, this.MIN_NORMAL_LUMA, this.MAX_NORMAL_LUMA,
      this.TARGET_MUTED_SATURATION, 0, this.MAX_MUTED_SATURATION);

    this.LightMutedSwatch = this.findColorVariation(this.TARGET_LIGHT_LUMA, this.MIN_LIGHT_LUMA, 1,
      this.TARGET_MUTED_SATURATION, 0, this.MAX_MUTED_SATURATION);

    return this.DarkMutedSwatch = this.findColorVariation(this.TARGET_DARK_LUMA, 0, this.MAX_DARK_LUMA,
      this.TARGET_MUTED_SATURATION, 0, this.MAX_MUTED_SATURATION);
  }

  generateEmptySwatches() {
    let hsl;
    if (this.VibrantSwatch === undefined) {
      // If we do not have a vibrant color...
      if (this.DarkVibrantSwatch !== undefined) {
        // ...but we do have a dark vibrant, generate the value by modifying the luma
        hsl = this.DarkVibrantSwatch.getHsl();
        hsl[2] = this.TARGET_NORMAL_LUMA;
        this.VibrantSwatch = new Swatch(Vibrant.hslToRgb(hsl[0], hsl[1], hsl[2]), 0);
      }
    }

    if (this.DarkVibrantSwatch === undefined) {
      // If we do not have a vibrant color...
      if (this.VibrantSwatch !== undefined) {
        // ...but we do have a dark vibrant, generate the value by modifying the luma
        hsl = this.VibrantSwatch.getHsl();
        hsl[2] = this.TARGET_DARK_LUMA;
        return this.DarkVibrantSwatch = new Swatch(Vibrant.hslToRgb(hsl[0], hsl[1], hsl[2]), 0);
      }
    }
  }

  findMaxPopulation() {
    let population = 0;
    for (let swatch of Array.from(this._swatches)) { population = Math.max(population, swatch.getPopulation()); }
    return population;
  }

  findColorVariation(targetLuma, minLuma, maxLuma, targetSaturation, minSaturation, maxSaturation) {
    let max = undefined;
    let maxValue = 0;

    for (let swatch of Array.from(this._swatches)) {
      const sat = swatch.getHsl()[1];
      const luma = swatch.getHsl()[2];

      if ((sat >= minSaturation) && (sat <= maxSaturation) &&
        (luma >= minLuma) && (luma <= maxLuma) &&
        !this.isAlreadySelected(swatch)) {
          const value = this.createComparisonValue(sat, targetSaturation, luma, targetLuma,
            swatch.getPopulation(), this.HighestPopulation);
          if ((max === undefined) || (value > maxValue)) {
            max = swatch;
            maxValue = value;
          }
        }
    }

    return max;
  }

  createComparisonValue(saturation, targetSaturation,
      luma, targetLuma, population, maxPopulation) {
    return this.weightedMean(
      this.invertDiff(saturation, targetSaturation), this.WEIGHT_SATURATION,
      this.invertDiff(luma, targetLuma), this.WEIGHT_LUMA,
      population / maxPopulation, this.WEIGHT_POPULATION
    );
  }

  invertDiff(value, targetValue) {
    return 1 - Math.abs(value - targetValue);
  }

  weightedMean(...values) {
    let sum = 0;
    let sumWeight = 0;
    let i = 0;
    while (i < values.length) {
      const value = values[i];
      const weight = values[i + 1];
      sum += value * weight;
      sumWeight += weight;
      i += 2;
    }
    return sum / sumWeight;
  }

  swatches() {
      return {
        Vibrant: this.VibrantSwatch,
        Muted: this.MutedSwatch,
        DarkVibrant: this.DarkVibrantSwatch,
        DarkMuted: this.DarkMutedSwatch,
        LightVibrant: this.LightVibrantSwatch,
        LightMuted: this.LightMuted
      };
    }


  isAlreadySelected(swatch) {
    return (this.VibrantSwatch === swatch) || (this.DarkVibrantSwatch === swatch) ||
      (this.LightVibrantSwatch === swatch) || (this.MutedSwatch === swatch) ||
      (this.DarkMutedSwatch === swatch) || (this.LightMutedSwatch === swatch);
  }

  static rgbToHsl(r, g, b) {
    r /= 255;
    g /= 255;
    b /= 255;
    const max = Math.max(r, g, b);
    const min = Math.min(r, g, b);
    let h = undefined;
    let s = undefined;
    const l = (max + min) / 2;
    if (max === min) {
      h = (s = 0);
      // achromatic
    } else {
      const d = max - min;
      s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
      switch (max) {
        case r:
          h = ((g - b) / d) + (g < b ? 6 : 0);
          break;
        case g:
          h = ((b - r) / d) + 2;
          break;
        case b:
          h = ((r - g) / d) + 4;
          break;
      }
      h /= 6;
    }
    return [h, s, l];
  }

  static hslToRgb(h, s, l) {
    let r = undefined;
    let g = undefined;
    let b = undefined;

    const hue2rgb = function(p, q, t) {
      if (t < 0) {
        t += 1;
      }
      if (t > 1) {
        t -= 1;
      }
      if (t < (1 / 6)) {
        return p + ((q - p) * 6 * t);
      }
      if (t < (1 / 2)) {
        return q;
      }
      if (t < (2 / 3)) {
        return p + ((q - p) * ((2 / 3) - t) * 6);
      }
      return p;
    };

    if (s === 0) {
      r = (g = (b = l));
      // achromatic
    } else {
      const q = l < 0.5 ? l * (1 + s) : (l + s) - (l * s);
      const p = (2 * l) - q;
      r = hue2rgb(p, q, h + (1 / 3));
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - (1 / 3));
    }
    return [
      r * 255,
      g * 255,
      b * 255
    ];
  }
};

Vibrant.initClass();

export default Vibrant;
