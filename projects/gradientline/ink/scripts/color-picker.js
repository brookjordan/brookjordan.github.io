import gradientLine from './gradient-line.js';
import { randomHexColor } from './helpers/color.js';


const colorsElt = document.querySelector('.colors');
const colorValues = [];
const colorElts   = [];
const colorPicker = {
  setColorsTo,
  addColorValue,
  removeColorValue,
};


export default colorPicker;


function addColorValue(colourToAdd, indexToAddTo = colorValues.length) {
  let newColor = typeof colourToAdd === 'string'
    ? colourToAdd
    : randomHexColor();
  colorValues.splice(indexToAddTo, 0, newColor);

  let newColorElt = document.createElement('input');
  newColorElt.value = newColor;
  newColorElt.type = 'color';
  colorsElt.insertBefore(newColorElt, colorElts[indexToAddTo]);
  colorElts.splice(indexToAddTo, 0, newColorElt);

  gradientLine.addColorValue(colourToAdd, indexToAddTo);

  return colorPicker;
}

function removeColorValue(indexToRemoveFrom = colorValues.length - 1) {
  colorValues.splice(indexToRemoveFrom, 1);
  colorsElt.removeChild(colorElts.splice(indexToRemoveFrom, 1)[0]);

  gradientLine.removeColorValue(indexToRemoveFrom);

  return colorPicker;
}

function setColorsTo(newColors) {
  let colorAddedCount = 0;

  while (colorValues.length) {
    removeColorValue();
  }
  while (colorAddedCount < newColors.length) {
    addColorValue(newColors[colorAddedCount]);
    colorAddedCount += 1;
  }

  return colorPicker;
}
