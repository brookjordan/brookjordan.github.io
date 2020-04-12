import "./elements/pokemon-3x3.js";
import shuffleArray from "./shuffle-array.js";
import findClosest from "./find-closest.js";
import getPokemon from "./pokemon.js";
const pokemonGrid = document.querySelector(".pokemon-images");
let focusedPokemon = null;
let pokemonPaddingElt = document.createElement("div");
function revealPokemon(pokemonElt) {
    pokemonElt.setAttribute("reveal", "");
}
function growPokemon(pokemonElt) {
    if (focusedPokemon) {
        if (focusedPokemon === pokemonElt) {
            return;
        }
        focusedPokemon.style.transition = null;
        focusedPokemon.style.transform = null;
        focusedPokemon.parentElement.insertBefore(focusedPokemon, pokemonPaddingElt);
        focusedPokemon.guessing = false;
        focusedPokemon = null;
    }
    pokemonElt.parentElement.insertBefore(pokemonPaddingElt, pokemonElt);
    focusedPokemon = pokemonElt;
    focusedPokemon.guessing = true;
    let focusedPokemonBounds = focusedPokemon.getBoundingClientRect();
    let pokemonPaddingEltBounds = pokemonPaddingElt.getBoundingClientRect();
    let scale = pokemonPaddingEltBounds.width / focusedPokemonBounds.width;
    let translateX = pokemonPaddingEltBounds.left - focusedPokemonBounds.left;
    let translateY = pokemonPaddingEltBounds.top - focusedPokemonBounds.top;
    focusedPokemon.style.transform = `
    translateX(calc(-50% + ${translateX}px))
    translateY(calc(-50% + ${translateY}px))
    scale(${scale})`;
    focusedPokemon.clientWidth;
    focusedPokemon.style.transition = "transform 0.3s cubic-bezier(.6, -0.2, .4, 1.2)";
    focusedPokemon.style.transform = `
    translateX(-50%)
    translateY(-50%)
    scale(1)`;
    focusedPokemon.setAttribute("guessing", "");
}
async function printPokemon() {
    let pokemonElts = document.createDocumentFragment();
    let pokemonData = await getPokemon();
    let shuffledPokemon = shuffleArray(pokemonData);
    shuffledPokemon.forEach(({ name }) => {
        let singlePokemonContainerElt = document.createElement("div");
        let singlePokemonElt = document.createElement("pokemon-3x3");
        singlePokemonElt.setAttribute("name", name);
        singlePokemonContainerElt.append(singlePokemonElt);
        singlePokemonElt.addEventListener("guess", (_event) => {
            if (!_event.hasOwnProperty("guess")) {
                return;
            }
            let event = _event;
            if (singlePokemonElt.name === event.guess) {
                alert(`That’s right, it’s ${singlePokemonElt.name}!`);
            }
            else {
                alert(`Nope, it’s ${singlePokemonElt.name}.`);
            }
            revealPokemon(singlePokemonElt);
            singlePokemonElt.classList.add("guessed-pokemon");
            focusedPokemon.style.transition = null;
            focusedPokemon.style.transform = null;
            focusedPokemon.parentElement.insertBefore(focusedPokemon, pokemonPaddingElt);
            focusedPokemon.removeAttribute("guessing");
            focusedPokemon = null;
        });
        pokemonElts.append(singlePokemonContainerElt);
    });
    // while (shuffledPokemon.length) {
    //   let aPokemon = shuffledPokemon.pop();
    //   let name = aPokemon.name;
    //   let singlePokemonContainerElt = document.createElement("div");
    //   let singlePokemonElt = document.createElement("pokemon-3x3");
    //   singlePokemonElt.setAttribute("name", name);
    //   singlePokemonContainerElt.append(singlePokemonElt);
    //   pokemonElts.append(singlePokemonContainerElt);
    // }
    pokemonGrid.append(pokemonElts);
}
printPokemon();
pokemonGrid.addEventListener("click", ({ target }) => {
    let pokemonElt = findClosest("pokemon-3x3", target);
    if (pokemonElt && !pokemonElt.classList.contains("guessed-pokemon")) {
        growPokemon(pokemonElt);
    }
});
//# sourceMappingURL=entry.js.map