import {
  directionalLight,
} from './parts.js';

let controlledLight = Object.keys(directionalLight)[0];

window.addEventListener('keypress', (e) => {
  let handleKeypress = {
    w() { directionalLight[controlledLight].translateY(1); },
    x() { directionalLight[controlledLight].translateY(-1); },
    d() { directionalLight[controlledLight].translateX(1); },
    a() { directionalLight[controlledLight].translateX(-1); },
    z() { directionalLight[controlledLight].translateZ(1); },
    e() { directionalLight[controlledLight].translateZ(-1); },
    s() {
      let lightNames = Object.keys(directionalLight);
      controlledLight = lightNames[(lightNames.indexOf(controlledLight) + 1) % lightNames.length];
      console.log(`Now controlling: ${controlledLight}`);
    },
  }[e.key];
  if (!handleKeypress) { return; }

  e.preventDefault();
  handleKeypress();

  console.dir({
    red: directionalLight.red.position,
    green: directionalLight.green.position,
    blue: directionalLight.blue.position,
  });
});
