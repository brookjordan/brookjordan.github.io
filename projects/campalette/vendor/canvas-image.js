/*
  CanvasImage Class
  Class that wraps the html image element and canvas.
  It also simplifies some of the canvas context manipulation
  with a set of helper functions.
  Stolen from https://github.com/lokesh/color-thief
*/

class CanvasImage {
  constructor(image) {
    this.canvas = document.createElement('canvas');
    this.context = this.canvas.getContext('2d');
    document.body.appendChild(this.canvas);
    this.width = (this.canvas.width = image.width);
    this.height = (this.canvas.height = image.height);
    this.context.drawImage(image, 0, 0, this.width, this.height);
  }

  clear() {
    return this.context.clearRect(0, 0, this.width, this.height);
  }

  update(imageData) {
    return this.context.putImageData(imageData, 0, 0);
  }

  getPixelCount() {
    return this.width * this.height;
  }

  getImageData() {
    return this.context.getImageData(0, 0, this.width, this.height);
  }

  removeCanvas() {
    return this.canvas.parentNode.removeChild(this.canvas);
  }
};

export default CanvasImage;
