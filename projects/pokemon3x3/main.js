import getLoadedImage from "./get-loaded-image.js";

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

  console.log(pokemonCountX * pokemonCountY);

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

async function printPokemon() {
  let pokemonImagesContainer = document.querySelector(".pokemon-images");
  let pokemonImages = await getImages();
  pokemonImages.forEach(src => {
    let singlePokemonImageContainer = document.createElement("div");
    let singlePokemonImg = new Image;
    singlePokemonImg.width = 3;
    singlePokemonImg.height = 3;
    singlePokemonImg.src = src;
    singlePokemonImageContainer.append(singlePokemonImg);
    pokemonImagesContainer.append(singlePokemonImageContainer);
  });
}

printPokemon();
