import "./elements/pokemon-3x3.js";
import shuffleArray from "./shuffle-array.js";
import findClosest from "./find-closest.js";
import getPokemon from "./pokemon.js";

const pokemonGrid = document.querySelector(".pokemon-images");

async function printPokemon() {
  let pokemonElts = document.createDocumentFragment();

  shuffleArray(await getPokemon()).forEach(({ name }) => {
    let singlePokemonImageContainer = document.createElement("pokemon-3x3");
    singlePokemonImageContainer.setAttribute("name", name);
    pokemonElts.append(singlePokemonImageContainer);
  });

  pokemonGrid.append(pokemonElts);
}

printPokemon();
pokemonGrid.addEventListener("click", ({ target }) => {
  let pokemonElt = findClosest("pokemon-3x3", target);
  if (pokemonElt) {
    pokemonElt.setAttribute("reveal", "");
  }
});
