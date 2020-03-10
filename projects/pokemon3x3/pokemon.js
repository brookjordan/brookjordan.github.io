import getLoadedImage from "./get-loaded-image.js";
import batchArray from "./batch-array.js";
import POKEMON_NAMES from "./pokemon-names.js";

const IMAGE_SRC = "./pokemon-3x3-27w.png";
const POKEMON = [];
let pokemonLoader = null;

function getPokemon() {
  pokemonLoader = new Promise(async (resolve, reject) => {
    if (POKEMON.length) {
      resolve(POKEMON)
      return;
    }

    if (pokemonLoader) {
      let pokemon = await pokemonLoader;
      resolve(pokemon);
      return;
    }

    let allPokemonImg = await getLoadedImage(IMAGE_SRC);
    let pokemonCountX = (allPokemonImg.naturalWidth + 1) / 4;
    let pokemonCountY = (allPokemonImg.naturalHeight + 1) / 4;

    let allPokemonCanvas = document.createElement("canvas");
    allPokemonCanvas.width = allPokemonImg.naturalWidth;
    allPokemonCanvas.height = allPokemonImg.naturalHeight;
    let allPokemonContext = allPokemonCanvas.getContext("2d");
    allPokemonContext.drawImage(allPokemonImg, 0, 0);

    let singlePokemonCanvas = document.createElement("canvas");
    singlePokemonCanvas.width = 3;
    singlePokemonCanvas.height = 3;
    let singlePokemonContext = singlePokemonCanvas.getContext("2d");

    POKEMON.push(...Array.from({ length: pokemonCountY }, (_, j) => j).flatMap(y => (
      Array.from({ length: pokemonCountX }, (_, k) => k).map(x => {
        let i = y * pokemonCountX + x;
        singlePokemonContext.clearRect(0, 0, 3, 3);
        singlePokemonContext.drawImage(
          allPokemonCanvas,
          x * 4, y * 4,
          3, 3,
          0, 0,
          3, 3,
        );
        let pokemonData = {
          name: POKEMON_NAMES[i],
          image: singlePokemonCanvas.toDataURL(),
          imageSrc: `./i/${POKEMON_NAMES[i]}.png`,
          colors: batchArray(singlePokemonContext.getImageData(0, 0, 3, 3).data, 4)
            .map(([r,g,b,a]) => a ? [r,g,b] : null),
        };
        return pokemonData;
      })
    )));

    resolve(POKEMON);
  });

  return pokemonLoader;
}

export default getPokemon;
