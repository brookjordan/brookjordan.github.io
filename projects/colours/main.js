let prm = new Promise((resolve) => { resolve() });

for (let pokemonName in pokedex) {
  const div = addPokemon(pokemonName);
  prm
    .then(() => getMostCommonColour(`./i/${pokedex[pokemonName].index}.png`))
    .then(colour => colourPokemon(div, colour));
}

function addPokemon(pokemonName) {
  const div = document.createElement('div');
  div.style.height = '120px';
  div.innerText = pokemonName;
  div.style.cssText = `
    background-image: url("./i/${pokedex[pokemonName].index}.png");
    background-position: 100% 50%;
    background-repeat: no-repeat;
    line-height: 40px;
    padding: 20px;
    font-family: "Raleway", sans-serif;
    font-weight: 100;
  `;
  document.body.appendChild(div);
  return div;
}

function colourPokemon(div, colour) {
  //div.style.backgroundColor = `rgb(${colour.rgba[0]},${colour.rgba[1]},${colour.rgba[2]})`;
  const colours = colour.map(colour => `rgb(${colour.rgba[0]},${colour.rgba[1]},${colour.rgba[2]})`);
  let grad = `${colours[0]} 25%,`;
  grad += `${colours[1]} 25%,${colours[1]} 50%,`;
  grad += `${colours[2]} 50%,${colours[2]} 75%,`;
  grad += `${colours[3]} 75%`;
  div.style.backgroundImage = `${div.style.backgroundImage}, linear-gradient(to right, ${grad})`;
}
