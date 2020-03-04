import getPokemon from "./pokemon.js";

const IMAGE_SRC = "./pokemon-3x3-27w.png";

async function printPokemon() {
  let pokemonImagesContainer = document.querySelector(".pokemon-images");
  (await getPokemon()).forEach(({ name, image }, i) => {
    let singlePokemonImageContainer = document.createElement("div");
    let singlePokemonImageWrapper = document.createElement("div");
    let singlePokemonLabel = document.createElement("h3");
    let singlePokemonImg = new Image;
    singlePokemonImg.width = 3;
    singlePokemonImg.height = 3;
    singlePokemonImg.src = image;
    singlePokemonLabel.textContent = name;

    singlePokemonImageWrapper.append(singlePokemonImg);
    singlePokemonImageWrapper.append(singlePokemonLabel);
    singlePokemonImageContainer.append(singlePokemonImageWrapper);
    pokemonImagesContainer.append(singlePokemonImageContainer);

    singlePokemonImageContainer.addEventListener("mouseenter", e => {
      let realisticPokemonImage = new Image;
      realisticPokemonImage.src = `./i/${name}.png`;
      realisticPokemonImage.classList.add("realistic-image");
      realisticPokemonImage.onload = e => {
        singlePokemonImageWrapper.prepend(realisticPokemonImage);
      };
    }, { once: true });
  });
}

printPokemon();
