import gradientLine from './gradient-line.js'
import { preventDefaultThen, passNoEvent } from './helpers/eventFunctions.js'
import COLOR_PALETTES from './color-palettes.js'
import colorPicker from './color-picker.js'
import pointerTrace from './pointer-trace/entry.js'


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
};

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
