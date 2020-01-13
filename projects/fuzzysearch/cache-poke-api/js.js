import allPokemon from "./pokemon.js";

let spritefulPokemon = allPokemon.filter(pokemon => !!pokemon.externalSpriteURL);
let pokemonToAdd = [...spritefulPokemon].reverse();
let pokemonElt = document.createElement('div');

function addNextPokemon() {
  if (pokemonToAdd.length) {
    let {
      name
    } = pokemonToAdd.pop();
    let elt = document.createElement('div');
    let label = document.createElement('h3');
    label.textContent = name;
    let img = new Image();
    img.loading = "lazy";
    img.role = "presentation";
    img.src = `./pokemon-images/${name}.png`;

    elt.classList.add('pokemon');
    img.classList.add('pokemon__image');
    elt.appendChild(img);
    label.classList.add('pokemon__label');
    elt.appendChild(label);
    pokemonElt.appendChild(elt);
    requestAnimationFrame(addNextPokemon);
  } else {
    appendPokemon();
  }
}

pokemonElt.classList.add('pokemon-list');
document.body.appendChild(pokemonElt);
addNextPokemon();
