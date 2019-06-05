import convertCSSColorFunction from './convert-css-colour.min.js';

class ColourFunctionPainter {
  static get inputProperties() {
    return [
      '--color-function',
    ];
  }

  paint(ctx, { width, height }, properties) {
    try {
      let colorString = properties.get('--color-function').toString();
      ctx.fillStyle = convertCSSColorFunction(colorString);
    } catch (e) {
      ctx.fillStyle = 'transparent';
    }
    ctx.fillRect(0, 0, width, height);
  }
}

registerPaint('color-function', ColourFunctionPainter);
