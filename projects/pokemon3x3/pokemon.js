import getLoadedImage from "./get-loaded-image.js";
import POKEMON_NAMES from "./pokemon-names.js";

const IMAGE_SRC = "./pokemon-3x3-27w.png";

async function getImages() {
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

  return Array.from({ length: pokemonCountY }, (_, i) => i).flatMap(y => (
    Array.from({ length: pokemonCountX }, (_, i) => i).map(x => {
      singlePokemonContext.clearRect(0, 0, 3, 3);
      singlePokemonContext.drawImage(
        allPokemonCanvas,
        x * 4, y * 4,
        3, 3,
        0, 0,
        3, 3,
      );
      return singlePokemonCanvas.toDataURL();
    })
  ));
}

async function getPokemon() {
  let pokemonImages = await getImages();
  return pokemonImages.map((imageSrc, i) => ({
    name: POKEMON_NAMES[i],
    image: imageSrc,
  }));
}

export default getPokemon;
