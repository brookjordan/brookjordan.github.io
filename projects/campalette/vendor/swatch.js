import Vibrant from '../vendor/vibrant.js';

class Swatch {
  static initClass() {
    this.prototype.hsl = undefined;
    this.prototype.rgb = undefined;
    this.prototype.population = 1;
    this.yiq = 0;
  }

  constructor(rgb, population) {
    this.rgb = rgb;
    this.population = population;
  }

  getHsl() {
    if (!this.hsl) {
      return this.hsl = Vibrant.rgbToHsl(this.rgb[0], this.rgb[1], this.rgb[2]);
    } else { return this.hsl; }
  }

  getPopulation() {
    return this.population;
  }

  getRgb() {
    return this.rgb;
  }

  getHex() {
    return `#${((1 << 24) + (this.rgb[0] << 16) + (this.rgb[1] << 8) + this.rgb[2]).toString(16).slice(1, 7)}`;
  }

  getTitleTextColor() {
    this._ensureTextColors();
    if (this.yiq < 200) { return "#fff"; } else { return "#000"; }
  }

  getBodyTextColor() {
    this._ensureTextColors();
    if (this.yiq < 150) { return "#fff"; } else { return "#000"; }
  }

  _ensureTextColors() {
    if (!this.yiq) { return this.yiq = ((this.rgb[0] * 299) + (this.rgb[1] * 587) + (this.rgb[2] * 114)) / 1000; }
  }
};

Swatch.initClass();

export default Swatch;
