var BROWSER_HAS = {
  INPUT_TYPE_COLOR: browserHasColorInput()
};

function browserHasColorInput() {
  var inputelt = document.createElement('input');
  inputelt.setAttribute('type', 'color');
  var hasColorInputType = inputelt.type === 'color' && 'style' in inputelt;

  if (hasColorInputType) {
    inputelt.value = '1)';
    hasColorInputType = inputelt.value != '1)';
  }

  return !!hasColorInputType;
}

function pageX(e) {
  return e.touches ? e.touches[0].clientX : e.pageX;
}

function pageY(e) {
  return e.touches ? e.touches[0].clientY : e.pageY;
}

function getLength(coordA, coordB) {
  return Math.sqrt(Math.pow(coordA[0] - coordB[0], 2) + Math.pow(coordA[1] - coordB[1], 2));
}

function hex2rgb$1(hexValue) {
  return (/^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hexValue)
  );
}

function randomHexColor() {
  return '#000000'.replace(/0/g, function () {
    return (~~(Math.random() * 16)).toString(16);
  });
}

var classCallCheck = function (instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
};











































var toConsumableArray = function (arr) {
  if (Array.isArray(arr)) {
    for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) arr2[i] = arr[i];

    return arr2;
  } else {
    return Array.from(arr);
  }
};

var newlineCtx = newlineelt.getContext('2d');
var canvasCtx = canvaselt.getContext('2d');
var colorValues = [];
var coords = undefined;
var penSize = 35;
var penColor = 'rgb(255,0,0)'; // red
var cavasBounds = void 0;
var undos = [];
var redos = [];
var previewMode = void 0;

var undoCheck_start = 0;
var undoCheck_end = 0;

var highFidelityLimit = 20000;

var gradientLine = {
  redo: redo,
  undo: undo,
  startDraw: startDraw,
  setColorsTo: setColorsTo$1,
  changePenSize: changePenSize$1,
  addColorValue: addColorValue,
  downloadImage: downloadImage,
  removeColorValue: removeColorValue,
  resizeAndClearAll: resizeAndClearAll,
  resizeAndClearNewline: resizeAndClearNewline
};

resizeAndClearAll();

window.addEventListener('load', function (e) {
  if (!BROWSER_HAS.INPUT_TYPE_COLOR) {
    var jscolorScript = document.createElement('script');
    jscolorScript.src = './jscolor.min.js';
    document.head.appendChild(jscolorScript);
  }
});

newlineelt.addEventListener('mousedown', startDraw);
newlineelt.addEventListener('touchstart', startDraw);

function setColorsTo$1(colorPalette) {
  var colors = colorPalette.colors.slice(0);

  var index = 0;
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
  render(previewMode ? coords : polishCoords(coords));
}

function polishCoords(coords) {
  var lastCoord = coords[coords.length - 1];
  var prevCoord = void 0;
  var prevSpeed = void 0;
  var newCoords = [];
  var prevSpd = 0;
  var smoothing = 20;

  coords.forEach(function (coord, index) {
    if (index) {
      var dist = getLength(prevCoord, coord);
      var speed = dist;
      var subCoords = [];
      smoothing = dist * 3;
      while (dist >= 1) {
        prevSpd = (speed + prevSpd * (smoothing - 1)) / smoothing;
        prevCoord = [prevCoord[0] - (prevCoord[0] - coord[0]) / dist, prevCoord[1] - (prevCoord[1] - coord[1]) / dist];
        subCoords.push([].concat(toConsumableArray(prevCoord), [prevSpd]));
        dist = getLength(prevCoord, coord);
      }
      newCoords = [].concat(toConsumableArray(newCoords), subCoords);
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
  var coords = _coords.slice(0);
  var colorCount = colorValues.length;
  var gradientCount = colorCount - 1;
  var coordsLength = _coords.length / (colorCount - 1);
  var coordsGroups = [];
  var color = void 0;

  resizeAndClearNewline();

  if (gradientCount) {
    var pointsDrawn = 0;
    var gradientsLeft = gradientCount;

    while (gradientsLeft) {
      coordsGroups.push(coords.splice(0, Math.round(coords.length / gradientsLeft)));
      gradientsLeft -= 1;
    }

    coordsGroups.forEach(function (coordGroup, index) {
      var color1 = rgb(colorValues[index]);
      var color2 = rgb(colorValues[index + 1]);
      var coordsLength = coordGroup.length;

      coordGroup.forEach(function (coord, index) {
        color = 'rgb(' + Math.round((color1[0] * (coordsLength - index) + color2[0] * index) / coordsLength) + ',' + (Math.round((color1[1] * (coordsLength - index) + color2[1] * index) / coordsLength) + ',') + (Math.round((color1[2] * (coordsLength - index) + color2[2] * index) / coordsLength) + ')');

        drawPoint(coord, color, penSize);
        pointsDrawn += 1;
      });
    });
  } else {
    var _color = colorValues[0];

    _coords.forEach(function (coord, index) {
      drawPoint(coord, _color, penSize);
    });
  }
}

function fillCircle(x, y, size) {
  var color = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : penColor;

  newlineCtx.beginPath();
  newlineCtx.fillStyle = color;
  newlineCtx.arc(x, y, size / 2, 0, 2 * Math.PI, false);
  newlineCtx.fill();
}

function drawPoint(coord, color, size) {
  fillCircle((coord[0] - cavasBounds.left) * devicePixelRatio, (coord[1] - cavasBounds.top) * devicePixelRatio, (coord[2] ? size / (Math.max(2, coord[2]) / 2) : size / 2) * devicePixelRatio, color);
}

function resizeAndClearAll(e) {
  resizeAndClearCanvas();
  resizeAndClearNewline();
}

function clearCanvas() {
  canvaselt.width = cavasBounds.width * devicePixelRatio;
  canvaselt.height = cavasBounds.height * devicePixelRatio;
}

function resizeAndClearCanvas() {
  cavasBounds = canvaselt.getBoundingClientRect();
  clearCanvas();
}

function resizeAndClearNewline() {
  cavasBounds = newlineelt.getBoundingClientRect();
  newlineelt.width = cavasBounds.width * devicePixelRatio;
  newlineelt.height = cavasBounds.height * devicePixelRatio;
}

function rgb(hex) {
  var result = hex2rgb$1(hex);
  return result ? [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)] : null;
}

function downloadImage() {
  var a = document.createElement('a');
  a.href = canvaselt.toDataURL();
  a.download = 'download';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
}

function addColorValue(colourToAdd) {
  var indexToAddTo = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : colorValues.length;

  var newColor = typeof colourToAdd === 'string' ? colourToAdd : '#000000'.replace(/0/g, function () {
    return (~~(Math.random() * 16)).toString(16);
  });
  colorValues.splice(indexToAddTo, 0, newColor);

  return gradientLine;
}

function updateColorValue(colorValueToAdd, indexOfColorToUpdate) {
  colorValues[indexOfColorToUpdate] = colorValueToAdd;
  updatingElt.value = colorValueToAdd;
}

function removeColorValue() {
  var indexToRemove = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : colorValues.length - 1;

  var colorValueToRemove = colorValues[indexToRemove];
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
    var _undo = undos.pop();
    redos.push(getCanvasData());
    clearCanvas();
    canvasCtx.putImageData(_undo, 0, 0);
  }
}

function redo() {
  if (redos.length) {
    var _redo = redos.pop();
    undos.push(getCanvasData());
    clearCanvas();
    canvasCtx.putImageData(_redo, 0, 0);
  }
}

function changePenSize$1(newPenSize) {
  !isNaN(newPenSize) && (penSize = newPenSize);
}

function preventDefaultThen(func) {
  var params = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : [];

  return function (event) {
    event.preventDefault();
    func.apply(undefined, toConsumableArray(params));
  };
}

var COLOR_PALETTES = [{
  name: 'Unicorn',
  backgroundColor: '#ffffff',
  version: '0.1.0',
  colors: ['#ffffff', '#fed1ef', '#def5ff']
}, {
  name: 'Inferno',
  backgroundColor: '#25190a',
  version: '0.1.0',
  colors: ['#25190a', '#c3d8f9', '#fcd80a', '#f7811a', '#ca4321', '#67190a', '#25190a']
}];

var colorsElt = document.querySelector('.colors');
var colorValues$1 = [];
var colorElts = [];
var colorPicker = {
  setColorsTo: setColorsTo$2,
  addColorValue: addColorValue$1,
  removeColorValue: removeColorValue$1
};

function addColorValue$1(colourToAdd) {
  var indexToAddTo = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : colorValues$1.length;

  var newColor = typeof colourToAdd === 'string' ? colourToAdd : randomHexColor();
  colorValues$1.splice(indexToAddTo, 0, newColor);

  var newColorElt = document.createElement('input');
  newColorElt.value = newColor;
  newColorElt.type = 'color';
  colorsElt.insertBefore(newColorElt, colorElts[indexToAddTo]);
  colorElts.splice(indexToAddTo, 0, newColorElt);

  gradientLine.addColorValue(colourToAdd, indexToAddTo);

  return colorPicker;
}

function removeColorValue$1() {
  var indexToRemoveFrom = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : colorValues$1.length - 1;

  colorValues$1.splice(indexToRemoveFrom, 1);
  colorsElt.removeChild(colorElts.splice(indexToRemoveFrom, 1)[0]);

  gradientLine.removeColorValue(indexToRemoveFrom);

  return colorPicker;
}

function setColorsTo$2(newColors) {
  var colorAddedCount = 0;

  while (colorValues$1.length) {
    removeColorValue$1();
  }
  while (colorAddedCount < newColors.length) {
    addColorValue$1(newColors[colorAddedCount]);
    colorAddedCount += 1;
  }

  return colorPicker;
}

var previousBreadcrumbDate = +new Date();

var HistoryBreadcrumb = function HistoryBreadcrumb(event) {
  classCallCheck(this, HistoryBreadcrumb);

  this.type = event.type;
  this.pause = +new Date() - previousBreadcrumbDate;
  this.timeStamp = previousBreadcrumbDate = previousBreadcrumbDate + this.pause;

  this.points = event.touches ? event.touches.map(function (touch) {
    return new FauxTouch(touch);
  }) : [new FauxTouch(event)];

  this.x = this.points[0].x;
  this.y = this.points[0].y;
};

var FauxTouch = function FauxTouch(touchOrEvent) {
  classCallCheck(this, FauxTouch);

  this.x = touchOrEvent.clientX;
  this.y = touchOrEvent.clientY;
};

var pointerBreadcrumbs = [];
var TOUCH_EVENTS = ['touchstart', 'touchend', 'touchmove'];
var maxBreadcrumbCount = 100;

window.addEventListener('mouseenter', traceMouse);
window.addEventListener('mousedown', traceMouse);
window.addEventListener('mousemove', traceMouse);
window.addEventListener('mouseup', traceMouse);
window.addEventListener('mouseleave', traceMouse);
window.addEventListener('touchstart', traceMouse);
window.addEventListener('touchmove', traceMouse);
window.addEventListener('touchend', traceMouse);
window.addEventListener('touchcancel', traceMouse);

function traceMouse(event) {
  var _ref = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
      _ref$preventDefault = _ref.preventDefault,
      preventDefault = _ref$preventDefault === undefined ? false : _ref$preventDefault,
      _ref$preventMouseSim = _ref.preventMouseSim,
      preventMouseSim = _ref$preventMouseSim === undefined ? true : _ref$preventMouseSim;

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

switchcolorselt.addEventListener('click', preventDefaultThen(function () {
  setColorsTo(COLOR_PALETTES[0].colors, COLOR_PALETTES[0].backgroundColor);
}));
switchcolorselt.addEventListener('touchstart', preventDefaultThen(function () {
  setColorsTo(COLOR_PALETTES[0].colors, COLOR_PALETTES[0].backgroundColor);
}));

window.addEventListener('keydown', handleKeyDown);

setColorsTo(COLOR_PALETTES[1].colors, COLOR_PALETTES[1].backgroundColor);

function setColorsTo(colors, backgroundColor) {
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
    switch (event.which) {
      case 90:
        // z
        event.preventDefault();
        if (event.shiftKey) {
          gradientLine.redo();
        } else {
          gradientLine.undo();
        }
        break;
      case 89:
        // y
        event.preventDefault();
        gradientLine.redo();
        break;
    }
  }
}

function changePenSize() {
  gradientLine.changePenSize(Math.pow(pensizeelt.value, 2));
}
