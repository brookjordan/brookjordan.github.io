import getLoadedImage from "./get-loaded-image.js";
import batchArray from "./batch-array.js";
import POKEMON_NAMES from "./pokemon-names.js";
;
;
const IMAGE_SRC = "./pokemon-3x3-27w.png";
const POKEMON = [];
let pokemonLoader = null;
function getPokemon() {
    pokemonLoader = new Promise(async (resolveLoader) => {
        if (POKEMON.length) {
            resolveLoader(POKEMON);
            return;
        }
        if (pokemonLoader) {
            let pokemon = await pokemonLoader;
            resolveLoader(pokemon);
            return;
        }
        let allPokemonImg = await getLoadedImage(IMAGE_SRC);
        let pokemonCountX = (allPokemonImg.naturalWidth + 1) / 4;
        let pokemonCountY = (allPokemonImg.naturalHeight + 1) / 4;
        let imageResolverSymbol = Symbol("image resolver");
        let coloursResolverSymbol = Symbol("colours resolve");
        let checkTime;
        checkTime = new Date().getTime();
        for (let y = 0; y < pokemonCountY; y += 1) {
            for (let x = 0; x < pokemonCountX; x += 1) {
                if (checkTime < new Date().getTime() - 100) {
                    checkTime = new Date().getTime();
                    await new Promise(r => requestAnimationFrame(() => r()));
                }
                let i = y * pokemonCountX + x;
                let pokemonImage = {
                    bigSrc: `./i/big-named/${POKEMON_NAMES[i]}.png`,
                    smallSrc: `./i/small-named/${POKEMON_NAMES[i]}.png`,
                };
                let pokemonData = {
                    x, y, i,
                    name: POKEMON_NAMES[i],
                    image: pokemonImage,
                };
                pokemonImage.abstractData = new Promise(res => {
                    pokemonData[imageResolverSymbol] = res;
                });
                pokemonData.colors = new Promise(res => {
                    pokemonData[coloursResolverSymbol] = res;
                });
                POKEMON.push(pokemonData);
            }
        }
        resolveLoader(POKEMON);
        await new Promise(r => requestAnimationFrame(() => r()));
        let allPokemonCanvas = document.createElement("canvas");
        allPokemonCanvas.width = allPokemonImg.naturalWidth;
        allPokemonCanvas.height = allPokemonImg.naturalHeight;
        let allPokemonContext = allPokemonCanvas.getContext("2d");
        allPokemonContext.drawImage(allPokemonImg, 0, 0);
        let singlePokemonCanvas = document.createElement("canvas");
        singlePokemonCanvas.width = 3;
        singlePokemonCanvas.height = 3;
        let singlePokemonContext = singlePokemonCanvas.getContext("2d");
        function addPokemon(pokemon) {
            singlePokemonContext.clearRect(0, 0, 3, 3);
            singlePokemonContext.drawImage(allPokemonCanvas, pokemon.x * 4, pokemon.y * 4, 3, 3, 0, 0, 3, 3);
            pokemon[imageResolverSymbol](singlePokemonCanvas.toDataURL());
            pokemon[coloursResolverSymbol](batchArray(singlePokemonContext.getImageData(0, 0, 3, 3).data, 4)
                .map(([r, g, b, a]) => a ? [r, g, b] : null));
        }
        checkTime = new Date().getTime();
        for (let i = 0; i < POKEMON.length; i += 1) {
            if (checkTime < new Date().getTime() - 100) {
                checkTime = new Date().getTime();
                await new Promise(r => requestAnimationFrame(() => r()));
            }
            addPokemon(POKEMON[i]);
        }
    });
    return pokemonLoader;
}
export default getPokemon;
//# sourceMappingURL=pokemon.js.map