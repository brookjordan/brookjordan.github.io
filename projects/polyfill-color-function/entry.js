CSS.paintWorklet.addModule('./color-function-worklet.js');

window.onload = e => {
  let root = document.documentElement;

  let ambientLightColorInput = document.createElement('input');
  ambientLightColorInput.type = 'color';
  ambientLightColorInput.onchange = e => {
    root.style.setProperty('--ambient-light', ambientLightColorInput.value);
  }
  ambientLightColorInput.value = getComputedStyle(root).getPropertyValue('--ambient-light').trim();
  document.body.prepend(ambientLightColorInput);

  let directLightColorInput = document.createElement('input');
  directLightColorInput.type = 'color';
  directLightColorInput.onchange = e => {
    root.style.setProperty('--direct-light', directLightColorInput.value);
  }
  directLightColorInput.value = getComputedStyle(root).getPropertyValue('--direct-light').trim();
  document.body.prepend(directLightColorInput);
}
