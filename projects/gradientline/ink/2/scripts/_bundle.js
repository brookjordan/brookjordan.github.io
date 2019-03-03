const BROWSER_HAS = {
  INPUT_TYPE_COLOR: browserHasColorInput(),
};

function browserHasColorInput() {
  var inputelt = document.createElement('input');
  inputelt.setAttribute('type', 'color');
  var hasColorInputType = inputelt.type === 'color' && 'style' in inputelt;

  if (hasColorInputType) {
    inputelt.value         = '1)';
    hasColorInputType = inputelt.value != '1)';
  }

  return !!hasColorInputType;
}

function pageX(e) {
  return e.touches
    ? e.touches[0].clientX
    : e.pageX;
}

function pageY(e) {
  return e.touches
    ? e.touches[0].clientY
    : e.pageY;
}

function getLength(coordA,
                          coordB) {
  return Math.sqrt(Math.pow(coordA[0] - coordB[0], 2) + Math.pow(coordA[1] - coordB[1], 2));
}

function hex2rgb$1(hexValue) {
  return /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hexValue);
}

function randomHexColor() {
  return '#000000'.replace(/0/g, () => (~~(Math.random()*16)).toString(16));
}

const newlineCtx = newlineelt.getContext('2d');
const canvasCtx  = canvaselt.getContext('2d');
const colorValues = [];
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
  setColorsTo: setColorsTo$1,
  changePenSize: changePenSize$1,
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

function setColorsTo$1(colorPalette) {
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

function startDraw(e) {
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

function addToDraw(e) {
  e.preventDefault();
  coords.push([pageX(e), pageY(e)]);
  render(previewMode
    ? coords
    : polishCoords(coords));
}

function polishCoords(coords) {
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

function endDraw(e) {
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

function render(_coords) {
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

function fillCircle(x, y, size, color=penColor) {
  newlineCtx.beginPath();
  newlineCtx.fillStyle = color;
  newlineCtx.arc(x, y, (size / 2), 0, (2 * Math.PI), false);
  newlineCtx.fill();
}

function drawPoint(coord, color, size) {
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

function resizeAndClearAll(e) {
  resizeAndClearCanvas();
  resizeAndClearNewline();
}

function clearCanvas() {
  canvaselt.width  = cavasBounds.width * devicePixelRatio;
  canvaselt.height = cavasBounds.height * devicePixelRatio;
}

function resizeAndClearCanvas() {
  cavasBounds      = canvaselt.getBoundingClientRect();
  clearCanvas();
}

function resizeAndClearNewline() {
  cavasBounds       = newlineelt.getBoundingClientRect();
  newlineelt.width  = cavasBounds.width * devicePixelRatio;
  newlineelt.height = cavasBounds.height * devicePixelRatio;
}

function rgb(hex) {
  let result = hex2rgb$1(hex);
  return result
    ? [
        parseInt(result[1], 16),
        parseInt(result[2], 16),
        parseInt(result[3], 16)
      ]
    : null;
}

function downloadImage() {
  let a = document.createElement('a');
  a.href = canvaselt.toDataURL();
  a.download = 'download';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
}

function addColorValue(colourToAdd, indexToAddTo = colorValues.length) {
  let newColor = typeof colourToAdd === 'string'
    ? colourToAdd
    : '#000000'.replace(/0/g,function(){return (~~(Math.random()*16)).toString(16);});
  colorValues.splice(indexToAddTo, 0, newColor);

  return gradientLine;
}

function updateColorValue(colorValueToAdd, indexOfColorToUpdate) {
  colorValues[indexOfColorToUpdate] = colorValueToAdd;
  updatingElt.value = colorValueToAdd;
}

function removeColorValue(indexToRemove = colorValues.length - 1) {
  let colorValueToRemove = colorValues[indexToRemove];
  if (colorValueToRemove) {
    colorValueToRemove && colorValues.splice(indexToRemove, 1);
  }

  return gradientLine;
}

function addToUndoStack() {
  redos = [];
  undos.push(getCanvasData());
  if (undos.length > 10) {
    undos = undos.slice(-10);
  }
}

function getCanvasData() {
  return canvasCtx.getImageData(0, 0, canvaselt.width, canvaselt.height);
}

function undo() {
  if (undos.length) {
    let undo = undos.pop();
    redos.push(getCanvasData());
    clearCanvas();
    canvasCtx.putImageData(undo, 0, 0);
  }
}

function redo() {
  if (redos.length) {
    let redo = redos.pop();
    undos.push(getCanvasData());
    clearCanvas();
    canvasCtx.putImageData(redo, 0, 0);
  }
}

function changePenSize$1(newPenSize) {
  !isNaN(newPenSize) && (penSize = newPenSize);
}

function preventDefaultThen(func, params = []) {
  return event => {
    event.preventDefault();
    func(...params);
  };
}

const COLOR_PALETTES = [
  {
    name: 'Unicorn',
    backgroundColor: '#ffffff',
    version: '0.1.0',
    colors: [
      '#ffffff',
      '#fed1ef',
      '#def5ff',
    ],
  },

  {
    name: 'Inferno',
    backgroundColor: '#25190a',
    version: '0.1.0',
    colors: [
      '#25190a',
      '#c3d8f9',
      '#fcd80a',
      '#f7811a',
      '#ca4321',
      '#67190a',
      '#25190a',
    ],
  },


];

const colorsElt = document.querySelector('.colors');
const colorValues$1 = [];
const colorElts   = [];
const colorPicker = {
  setColorsTo: setColorsTo$2,
  addColorValue: addColorValue$1,
  removeColorValue: removeColorValue$1,
};


function addColorValue$1(colourToAdd, indexToAddTo = colorValues$1.length) {
  let newColor = typeof colourToAdd === 'string'
    ? colourToAdd
    : randomHexColor();
  colorValues$1.splice(indexToAddTo, 0, newColor);

  let newColorElt = document.createElement('input');
  newColorElt.value = newColor;
  newColorElt.type = 'color';
  colorsElt.insertBefore(newColorElt, colorElts[indexToAddTo]);
  colorElts.splice(indexToAddTo, 0, newColorElt);

  gradientLine.addColorValue(colourToAdd, indexToAddTo);

  return colorPicker;
}

function removeColorValue$1(indexToRemoveFrom = colorValues$1.length - 1) {
  colorValues$1.splice(indexToRemoveFrom, 1);
  colorsElt.removeChild(colorElts.splice(indexToRemoveFrom, 1)[0]);

  gradientLine.removeColorValue(indexToRemoveFrom);

  return colorPicker;
}

function setColorsTo$2(newColors) {
  let colorAddedCount = 0;

  while (colorValues$1.length) {
    removeColorValue$1();
  }
  while (colorAddedCount < newColors.length) {
    addColorValue$1(newColors[colorAddedCount]);
    colorAddedCount += 1;
  }

  return colorPicker;
}

let previousBreadcrumbDate = +new Date();

class HistoryBreadcrumb {
  constructor(event) {
    this.type      = event.type;
    this.pause     = +new Date() - previousBreadcrumbDate;
    this.timeStamp = previousBreadcrumbDate = previousBreadcrumbDate + this.pause;

    this.points = event.touches
      ? event.touches.map(touch => new FauxTouch(touch))
      : [new FauxTouch(event)];

    this.x = this.points[0].x;
    this.y = this.points[0].y;
  }
}

class FauxTouch {
  constructor(touchOrEvent) {
    this.x = touchOrEvent.clientX;
    this.y = touchOrEvent.clientY;
  }
}

const pointerBreadcrumbs = [];
const TOUCH_EVENTS = [
  'touchstart',
  'touchend',
  'touchmove',
];
let maxBreadcrumbCount = 100;

window.addEventListener('mouseenter', traceMouse);
window.addEventListener('mousedown', traceMouse);
window.addEventListener('mousemove', traceMouse);
window.addEventListener('mouseup', traceMouse);
window.addEventListener('mouseleave', traceMouse);
window.addEventListener('touchstart', traceMouse);
window.addEventListener('touchmove', traceMouse);
window.addEventListener('touchend', traceMouse);
window.addEventListener('touchcancel', traceMouse);


function traceMouse(event,
                    {
                      preventDefault  = false,
                      preventMouseSim = true
                    } = {}) {
  if (preventDefault || preventMouseSim && TOUCH_EVENTS.includes(event.type)) {
    event.preventDefault();
  }

  pointerBreadcrumbs.push(new HistoryBreadcrumb(event));
  if (pointerBreadcrumbs.length > maxBreadcrumbCount) {
    pointerBreadcrumbs.splice(0, pointerBreadcrumbs.length - maxBreadcrumbCount);
  }
}

window.addEventListener('resize', gradientLine.resizeAndClearNewline);

clearcanvaselt.addEventListener('click', gradientLine.resizeAndClearAll);
clearcanvaselt.addEventListener('touchstart', gradientLine.resizeAndClearAll);

downloadimageelt.addEventListener('click', gradientLine.downloadImage);
downloadimageelt.addEventListener('touchstart', gradientLine.downloadImage);

undoelt.addEventListener('click', gradientLine.undo);
undoelt.addEventListener('touchstart', preventDefaultThen(gradientLine.undo));

redoelt.addEventListener('click', gradientLine.redo);
redoelt.addEventListener('touchstart', preventDefaultThen(gradientLine.redo));

addcolorelt.addEventListener('click', preventDefaultThen(colorPicker.addColorValue));
addcolorelt.addEventListener('touchstart', preventDefaultThen(colorPicker.addColorValue));
removecolorelt.addEventListener('click', preventDefaultThen(colorPicker.removeColorValue));
removecolorelt.addEventListener('touchstart', preventDefaultThen(colorPicker.removeColorValue));

backgroundcolorelt.addEventListener('input', changeBackgroundColorTo);

pensizeelt.addEventListener('change', preventDefaultThen(changePenSize));

switchcolorselt.addEventListener('click', preventDefaultThen(() => {
  setColorsTo(COLOR_PALETTES[0].colors,
              COLOR_PALETTES[0].backgroundColor);
}));
switchcolorselt.addEventListener('touchstart', preventDefaultThen(() => {
  setColorsTo(COLOR_PALETTES[0].colors,
              COLOR_PALETTES[0].backgroundColor);
}));

window.addEventListener('keydown', handleKeyDown);

setColorsTo(COLOR_PALETTES[1].colors,
            COLOR_PALETTES[1].backgroundColor);


function setColorsTo(colors,
                     backgroundColor) {
  colorPicker.setColorsTo(colors);
  if (backgroundColor) {
    changeBackgroundColorTo(backgroundColor);
  }
}

function changeBackgroundColorTo(to) {
  if (typeof to === 'string') {
    backgroundcolorelt.value = to;
  }
  document.body.style.backgroundColor = backgroundcolorelt.value;

  return gradientLine;
}

function handleKeyDown(event) {
  if (event.ctrlKey || event.metaKey) {
    switch(event.which) {
      case 90: // z
        event.preventDefault();
        if (event.shiftKey) {
          gradientLine.redo();
        } else {
          gradientLine.undo();
        }
        break;
      case 89: // y
        event.preventDefault();
        gradientLine.redo();
        break;
    }
  }
}

function changePenSize() {
  gradientLine.changePenSize(Math.pow(pensizeelt.value, 2));
}
