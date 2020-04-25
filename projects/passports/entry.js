import countries from "./countries.js";

const states = ["no-entry", "visa-on-entry", "no-visa"];

let mapSVG = document.createElementNS("http://www.w3.org/2000/svg", "svg");
mapSVG.setAttribute("viewBox", "0 0 2000 1001");
mapSVG.classList.add("svg-map");

let mapStyle = document.createElementNS("http://www.w3.org/2000/svg", "style");
mapStyle.innerHTML = `
  .svg-map__country {
    transition: 0.2s;
    transition-property:
      fill,
      stroke-width,
      stroke,
      stroke-dasharray;
  }
  .svg-map__country--no-entry {
    fill: hsl(var(--hue), 10%, 85%);
    stroke: rgb(0 0 0 / 0);
    stroke-dasharray: 10, 0;
  }
  .svg-map__country--visa-on-entry {
    fill: hsl(var(--hue), 10%, 50%);
    stroke-width: 2;
    stroke: rgb(0 0 0 / 0.5);
    stroke-dasharray: 5, 5;
  }
  .svg-map__country--no-visa {
    fill: hsl(var(--hue), 70%, 40%);
    stroke-width: 2;
    stroke: black;
  }
`;
mapSVG.append(mapStyle);

let countryPaths = countries.map(function buildCountry(countryData) {
  let state = null;
  const hue = Math.random() * 360;

  const countryPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
  countryPath.setAttribute("d", countryData.d);
  countryPath.classList.add(`svg-map__country`);
  countryPath.classList.add(`svg-map__country--${countryData.code}`);
  countryPath.style.setProperty('--hue', hue);
  Object.defineProperty(countryPath, "state", {
    set(newState) {
      if (newState === state) { return; }
      if (states.includes(newState)) {
        countryPath.classList.remove(`svg-map__country--${state}`);
        countryPath.classList.add(`svg-map__country--${newState}`);
        state = newState;
      }
    },
    get() {
      return state;
    },
  });
  countryPath.state = states[0];


  return countryPath;
});

countryPaths.forEach(function appendCountry(countryElement) {
  mapSVG.append(countryElement);
});

document.body.append(mapSVG);
