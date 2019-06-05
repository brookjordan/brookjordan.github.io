CSS.paintWorklet.addModule('./color-function-worklet.js');

window.onload = e => {
  let mainCircle = document.querySelector('div');

  let ambientLightColorInput = document.createElement('input');
  ambientLightColorInput.type = 'color';
  ambientLightColorInput.onchange = e => {
    mainCircle.style.setProperty('--ambient-light', ambientLightColorInput.value);
  }

  ambientLightColorInput.value = getComputedStyle(mainCircle).getPropertyValue('--ambient-light').trim();
  document.body.prepend(ambientLightColorInput);

  let directLightColorInput = document.createElement('input');
  directLightColorInput.type = 'color';
  directLightColorInput.onchange = e => {
    mainCircle.style.setProperty('--direct-light', directLightColorInput.value);
  }

  directLightColorInput.value = getComputedStyle(mainCircle).getPropertyValue('--direct-light').trim();
  document.body.prepend(directLightColorInput);
}
