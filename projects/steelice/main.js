// Stating conditions
const cubeSideLength   = 6;   // cm
const cubeTemparature  = -5;  // °C
const waterVolume      = 500; // cm³
const waterTemparature = 5;   // °C

// Simulation settings
const tickDuration    = 1;
const speedMultiplier = 120;
const consolePeriod   = 125;

// Constants
const ROOM_TEMP = K(24);

const SPECIFIC_HEAT_CAPACITY = { // J / (g * K)
  steel: 0.48,
  ice:   0.21,
  water: 4.186,
};

const SPECIFIC_LATENT_HEAT_OF_FUSION = { // J / g
  ice: 15,
};

const DENSITY = { // g / cm³
  steel: 7.80,
  ice: 0.9167,
  water: 0.997,
};

const MELTING_POINT = { // °K
  steel: K(1420),
  ice: K(0),
  water: K(0),
};

/*
TODO: I want this value for "water => steel" and "water => ice" as:
J / s / cm² * 𝛿K
*/
const HEAT_TRANSFER_COEFFICIENT = { // J / s / cm² * 𝛿K
  ice: 0.003, 
  steel: 0.001, 
  air: 0.0002, 
};


// Calculated initial vars
let cubeVolume = Math.pow(cubeSideLength, 3); // cm³

const TEMP = { // °K
  steel:      K(cubeTemparature),
  ice:        K(cubeTemparature),
  steelWater: K(waterTemparature),
  iceWater:   K(waterTemparature),
};

const MASS = { // g
  steel: getMass('steel', cubeVolume),
  ice:   getMass('ice',   cubeVolume),
  water: getMass('water', waterVolume),
};

const ENERGY = { // J
  steel: getEnergy('steel', TEMP.steel, cubeVolume),
  ice:   getEnergy('ice',   TEMP.ice,   cubeVolume),
  steelWater: getEnergy('water', TEMP.steelWater, waterVolume),
  iceWater: getEnergy('water', TEMP.iceWater, waterVolume),
};

function simSteelToWater() {
  let heatTransferedFromSteel = getHeatEnergyTransfer('steel', TEMP.steelWater, TEMP.steel, cubeArea(cubeSideLength));
  let heatTransferedToAir = getHeatEnergyTransfer('air', TEMP.steelWater, ROOM_TEMP, cubeArea(cubeSideLength));

  ENERGY.steelWater -= heatTransferedFromSteel + heatTransferedToAir;
  ENERGY.steel += heatTransferedFromSteel;
  TEMP.steelWater = getTemp('water', ENERGY.steelWater, waterVolume);
  TEMP.steel = getTemp('steel', ENERGY.steel, Math.pow(cubeSideLength, 3));
}

function simIceToWater() {
  let heatTransferedFromIce = getHeatEnergyTransfer('ice', TEMP.iceWater, TEMP.ice, cubeArea(iceCubeSideLength));
  let heatTransferedToAir = getHeatEnergyTransfer('air', TEMP.iceWater, ROOM_TEMP, cubeArea(cubeSideLength));

  ENERGY.iceWater -= heatTransferedFromIce + heatTransferedToAir;
  TEMP.iceWater = getTemp('water', ENERGY.iceWater, waterVolume);

  let iceMelted = heatTransferedFromIce / SPECIFIC_LATENT_HEAT_OF_FUSION.ice;
  iceWaterVolume += iceMelted * DENSITY.water;
  MASS.ice = Math.max(0, MASS.ice - iceMelted);
  iceVolume = MASS.ice / DENSITY.ice;
  iceCubeSideLength = Math.pow(iceVolume, 1/3);
  ENERGY.ice = getEnergy('ice', TEMP.ice, iceVolume);
}


function startSim({
  tickDuration = 1000,
  speedMultiplier = 1,
  intialSims = [],
} = {}) {
  const tickMS = tickDuration / speedMultiplier;
  const sims   = intialSims;
  let prevNow  = performance.now();
  let left     = 0;
  window.ll = prevNow;
  
  iter();
  function iter() {
    let now = performance.now();
    left += now - prevNow;

    while(left - tickMS >= 0) {
      sims.forEach(sim => { sim(); });
      left -= tickMS;
    }

    if (now - window.ll > consolePeriod) {
      window.ll = performance.now();
      i += 0.5;
    //   console.log(`
    //     Minute ${i.toFixed(1)}:
    //     Steel water temp: ${C(TEMP.steelWater).toFixed(2)}°C
    //     Ice water temp: ${C(TEMP.iceWater).toFixed(2)}°C

    //     Steel temp: ${C(TEMP.steel).toFixed(2)}°C
    //     Ice size: ${iceCubeSideLength.toFixed(2)}cm
    //   `.replace(/ {2,}/g, ''));
    }

    updateTime(i.toFixed(1));
    renderSteel();
    renderIce();

    prevNow = now;
    requestAnimationFrame(iter);
  }
  
  return {
    add(func) { sims.push(func); },
  };
}

function K(c) {
  return c + 273.15;
}

function C(k) {
  return k - 273.15;
}

function cubeArea(sideLength) {
  return sideLength * sideLength * 6;
}

function getCubeSideLength(joules, material='ice') {
  return joules >= 0
    ? Math.pow(joules / (SPECIFIC_HEAT_CAPACITY[material] * DENSITY[material] * K(-5)), 1/3)
    : 0;
}

function getHeatEnergyTransfer(material, temp1, temp2, cubeSideLength) {
  return (HEAT_TRANSFER_COEFFICIENT[material] * (tickDuration / 1000) * cubeSideLength) * (temp1 - temp2);
}

function getMass(material, volume) {
  return DENSITY[material] * volume;
}

function getTemp(material, energy, volume) {
  return energy / (getMass(material, volume) * SPECIFIC_HEAT_CAPACITY[material]);
}

function getEnergy(material, temperature, volume) {
  return SPECIFIC_HEAT_CAPACITY[material] * getMass(material, volume) * temperature;
}

function m3(cm3) {
  return cm3 / 1000000
}

function cm3(m3) {
  return m3 * 1000000
}

function m2(cm2) {
  return cm2 / 10000;
}

function cm2(m2) {
  return m2 * 10000;
}

function m(cm) {
  return cm / 100;
}

function cm(m) {
  return m * 100;
}

const minTemp   = K(-5);
const maxTemp   = K(24);
const tempRange = maxTemp - minTemp;

const steelElt = document.querySelector('.steel');
const steelGlassElt = document.querySelector('.glass--steel');
const steelGlassTextElt = document.querySelector('.glass-text--steel');
function renderSteel() {
  steelElt.innerHTML = `${C(TEMP.steel).toFixed(2)}°C`;
  steelGlassTextElt.innerHTML = `${C(TEMP.steelWater).toFixed(2)}°C`;
  steelElt.style.backgroundColor = tempColor(TEMP.steel);
  steelGlassElt.style.backgroundColor = tempColor(TEMP.steelWater);
}

const iceElt = document.querySelector('.ice');
const iceGlassElt = document.querySelector('.glass--ice');
const iceGlassTextElt = document.querySelector('.glass-text--ice');
iceElt.style.backgroundColor = tempColor(TEMP.ice);
function renderIce() {
  iceGlassTextElt.innerHTML = `${C(TEMP.iceWater).toFixed(2)}°C`;
  iceElt.innerHTML = `${iceCubeSideLength.toFixed(1)}cm`;
  iceElt.style.width = iceElt.style.height = `${iceCubeSideLength * 5}vmin`;
  iceGlassElt.style.backgroundColor = tempColor(TEMP.iceWater);
  iceGlassElt.style.height = `${(iceWaterVolume + Math.pow(iceCubeSideLength, 3)) / 50 * 5}vmin`;
}

const titleElt = document.querySelector('h1');
function updateTime(newTime) {
  titleElt.innerHTML = `${newTime} mins`;
}

function tempColor(temp) {
  let tempClr = Math.round(255 * ((temp - minTemp) / tempRange));
  return `rgb(${tempClr},${tempClr},255)`;
}


let iceCubeSideLength = cubeSideLength;
let iceWaterVolume    = waterVolume; // cm³

let i = 0;
let sim = startSim({
  tickDuration,
  speedMultiplier,
  intialSims: [
    simSteelToWater,
    simIceToWater,
  ],
});
