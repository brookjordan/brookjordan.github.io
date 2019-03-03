'use strict';

import BROWSER_HAS    from './browser-has.js';
import { pageX, pageY } from './helpers/events.js';
import { getLength } from './helpers/vectors.js';
import { hex2rgb } from './helpers/color.js';

const newlineCtx = newlineelt.getContext('2d');
const canvasCtx  = canvaselt.getContext('2d');
const colorValues = [];
const events = {};
let coords   = undefined;
let penSize  = 35;
let penColor = 'rgb(255,0,0)'; // red
let cavasBounds;
let undos = [];
let redos = [];
let previewMode;

let undoCheck_start = 0;
let undoCheck_end = 0;

let highFidelityLimit = 20000;

const gradientLine = {
  redo,
  undo,
  startDraw,
  setColorsTo,
  changePenSize,
  addColorValue,
  downloadImage,
  removeColorValue,
  resizeAndClearAll,
  resizeAndClearNewline,
};


resizeAndClearAll();

window.addEventListener('load', e => {
  if (!BROWSER_HAS.INPUT_TYPE_COLOR) {
    const jscolorScript = document.createElement('script');
    jscolorScript.src = './jscolor.min.js';
    document.head.appendChild(jscolorScript);
  }
});

newlineelt.addEventListener('mousedown', startDraw);
newlineelt.addEventListener('touchstart', startDraw);

export default gradientLine;


export function setColorsTo(colorPalette) {
  let colors = colorPalette.colors.slice(0);

  let index = 0;
  while (colorValues.length > index && index < colors.length) {
    updateColorValue(colors[index], index);
    index += 1;
  }
  while (index < colors.length) {
    addColorValue(colors[index]);
    index += 1;
  }
  while (colorValues.length > colors.length) {
    removeColorValue();
  }

  return gradientLine;
}

export function startDraw(e) {
  e.preventDefault();

  previewMode = false;
  coords = [[pageX(e), pageY(e)]];
  newlineelt.addEventListener('mousemove', addToDraw);
  newlineelt.addEventListener('touchmove', addToDraw);

  newlineelt.addEventListener('mouseup', endDraw);
  newlineelt.addEventListener('touchend', endDraw);
  newlineelt.addEventListener('mouseleave', endDraw);

  if (undoCheck_start === undoCheck_end) {
    undoCheck_start += 1;
  }
}

export function addToDraw(e) {
  e.preventDefault();
  coords.push([pageX(e), pageY(e)]);
  render(previewMode
    ? coords
    : polishCoords(coords));
}

export function polishCoords(coords) {
  let lastCoord = coords[coords.length - 1];
  let prevCoord;
  let prevSpeed;
  let newCoords = [];
  let prevSpd = 0;
  let smoothing = 20;

  coords.forEach((coord, index) => {
    if (index) {
      let dist = getLength(prevCoord, coord);
      let speed = dist;
      let subCoords = [];
      smoothing = dist * 3;
      while(dist >= 1) {
        prevSpd = (speed + (prevSpd * (smoothing - 1))) / smoothing;
        prevCoord = [prevCoord[0] - (prevCoord[0] - coord[0]) / dist, prevCoord[1] - (prevCoord[1] - coord[1]) / dist];
        subCoords.push([...prevCoord, prevSpd]);
        dist = getLength(prevCoord, coord);
      }
      newCoords = [...newCoords, ...subCoords];
    } else {
      newCoords.push(coord);
      prevCoord = coord;
    }
  });

  if (newCoords.length > highFidelityLimit) {
    previewMode = true;
  }

  return newCoords;
}

export function endDraw(e) {
  e.preventDefault();

  newlineelt.removeEventListener('mousemove', addToDraw);
  newlineelt.removeEventListener('touchmove', addToDraw);

  newlineelt.removeEventListener('mouseup', endDraw);
  newlineelt.removeEventListener('touchend', endDraw);
  newlineelt.removeEventListener('mouseleave', endDraw);

  if (undoCheck_end !== undoCheck_start) {
    undoCheck_end = undoCheck_start;
    addToUndoStack();
  }

  render(polishCoords(coords));
  canvasCtx.drawImage(newlineelt, 0, 0, canvaselt.width, canvaselt.height);
  resizeAndClearNewline();
}

export function render(_coords) {
  let coords           = _coords.slice(0);
  let colorCount       = colorValues.length;
  let gradientCount    = colorCount - 1;
  let coordsLength     = _coords.length / (colorCount - 1);
  let coordsGroups     = [];
  let color;

  resizeAndClearNewline();

  if (gradientCount) {
    let pointsDrawn   = 0;
    let gradientsLeft = gradientCount;

    while (gradientsLeft) {
      coordsGroups.push(coords.splice(0, Math.round(coords.length / gradientsLeft)));
      gradientsLeft -= 1;
    }

    coordsGroups.forEach((coordGroup, index) => {
      let color1       = rgb(colorValues[index]);
      let color2       = rgb(colorValues[index + 1]);
      let coordsLength = coordGroup.length;

      coordGroup.forEach((coord, index) => {
        color =
          `rgb(${Math.round(((color1[0] * ( coordsLength - index )) + (color2[0] * index)) / coordsLength)},` +
              `${Math.round(((color1[1] * ( coordsLength - index )) + (color2[1] * index)) / coordsLength)},` +
              `${Math.round(((color1[2] * ( coordsLength - index )) + (color2[2] * index)) / coordsLength)})`;

        drawPoint(coord, color, penSize);
        pointsDrawn += 1;
      });
    });
  } else {
    let color = colorValues[0];

    _coords.forEach((coord, index) => {
      drawPoint(coord, color, penSize);
    });
  }
}

export function fillCircle(x, y, size, color=penColor) {
  newlineCtx.beginPath();
  newlineCtx.fillStyle = color;
  newlineCtx.arc(x, y, (size / 2), 0, (2 * Math.PI), false);
  newlineCtx.fill();
}

export function drawPoint(coord, color, size) {
  fillCircle(
    (coord[0] - cavasBounds.left) * devicePixelRatio,
    (coord[1] - cavasBounds.top)  * devicePixelRatio,
    (
      coord[2]
        ? size / (Math.max(2, coord[2]) / 2)
        : size / 2
    ) * devicePixelRatio,
    color,
  );
}

export function resizeAndClearAll(e) {
  resizeAndClearCanvas();
  resizeAndClearNewline();
}

export function clearCanvas() {
  canvaselt.width  = cavasBounds.width * devicePixelRatio;
  canvaselt.height = cavasBounds.height * devicePixelRatio;
}

export function resizeAndClearCanvas() {
  cavasBounds      = canvaselt.getBoundingClientRect();
  clearCanvas();
}

export function resizeAndClearNewline() {
  cavasBounds       = newlineelt.getBoundingClientRect();
  newlineelt.width  = cavasBounds.width * devicePixelRatio;
  newlineelt.height = cavasBounds.height * devicePixelRatio;
}

export function rgb(hex) {
  let result = hex2rgb(hex);
  return result
    ? [
        parseInt(result[1], 16),
        parseInt(result[2], 16),
        parseInt(result[3], 16)
      ]
    : null;
}

export function downloadImage() {
  let a = document.createElement('a');
  a.href = canvaselt.toDataURL();
  a.download = 'download';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
}

export function addColorValue(colourToAdd, indexToAddTo = colorValues.length) {
  let newColor = typeof colourToAdd === 'string'
    ? colourToAdd
    : '#000000'.replace(/0/g,function(){return (~~(Math.random()*16)).toString(16);});
  colorValues.splice(indexToAddTo, 0, newColor);

  return gradientLine;
}

export function updateColorValue(colorValueToAdd, indexOfColorToUpdate) {
  colorValues[indexOfColorToUpdate] = colorValueToAdd;
  updatingElt.value = colorValueToAdd;
}

export function removeColorValue(indexToRemove = colorValues.length - 1) {
  let colorValueToRemove = colorValues[indexToRemove];
  if (colorValueToRemove) {
    colorValueToRemove && colorValues.splice(indexToRemove, 1);
  }

  return gradientLine;
}

export function addToUndoStack() {
  redos = [];
  undos.push(getCanvasData());
  if (undos.length > 10) {
    undos = undos.slice(-10);
  }
}

export function getCanvasData() {
  return canvasCtx.getImageData(0, 0, canvaselt.width, canvaselt.height);
}

export function undo() {
  if (undos.length) {
    let undo = undos.pop();
    redos.push(getCanvasData());
    clearCanvas();
    canvasCtx.putImageData(undo, 0, 0);
  }
}

export function redo() {
  if (redos.length) {
    let redo = redos.pop();
    undos.push(getCanvasData());
    clearCanvas();
    canvasCtx.putImageData(redo, 0, 0);
  }
}

export function changePenSize(newPenSize) {
  !isNaN(newPenSize) && (penSize = newPenSize);
}
