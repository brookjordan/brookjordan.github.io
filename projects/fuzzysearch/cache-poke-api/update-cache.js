const REQUEST_MISSING_SPRITE_URLS = !!process.env.REQUEST_MISSING_SPRITE_URLS || false;

const path = require("path");
const fs = require("fs");
const https = require("https");
const Stream = require('stream').Transform;

const ALL_POKEMON_URLS = JSON.parse(fs.readFileSync(path.join(__dirname, "cached-pokemon-urls.json")));
const ALL_POKEMON = JSON.parse(fs.readFileSync(path.join(__dirname, "cached-pokemon.json")));

function pokemonWithSprites() {
  return ALL_POKEMON.filter(pokemon => pokemon.sprite);
}

function getJSON(URL) {
  return new Promise((resolve, reject) => {
    https.get(URL, (res) => {
      let body = "";
  
      res.on("data", (chunk) => {
        body += chunk;
      });
  
      res.on("end", () => {
        try {
          resolve(JSON.parse(body));
        } catch (error) {
          reject(error.message);
        };
      });
    })
    .on("error", (error) => {
      reject(error.message);
    });
  });
}

function pokemonSpriteExists(name) {
  return !!ALL_POKEMON.find(pokemon => (
    pokemon.name === name
    && (
      !REQUEST_MISSING_SPRITE_URLS
      || pokemon.externalSpriteURL
    )
  ));
}

async function getPokemonURLList() {
  if (ALL_POKEMON_URLS) {
    console.log("Using cached pokemon URLs.");
    return ALL_POKEMON_URLS;
  }

  let nextURL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=200";
  let newPokemon;
  while (nextURL){
    let data;
    try {
      data = await getJSON(nextURL);
    } catch (error) { console.log(error); return; }

    newPokemon = data.results;
    nextURL = data.next;
    ALL_POKEMON_URLS.push(...newPokemon);
    fs.writeFileSync(path.join(__dirname, "cached-pokemon-urls.json"), JSON.stringify(ALL_POKEMON_URLS, null, 2));
    console.log("Gathering data URLs…");
  }
  console.log("Finished gathering data URLs.");
}

async function getPokemon() {
  let remainingPokemonDataURLs = [...ALL_POKEMON_URLS].reverse();
  while (remainingPokemonDataURLs.length) {
    let {name, url} = remainingPokemonDataURLs.pop();
    if (pokemonSpriteExists(name)) { continue; }

    try {
      let data = await getJSON(url);
      if (!data.sprites.front_default) {
        console.log(`No sprite URL found for ${data.name}.`);
        continue;
      }
      ALL_POKEMON.push({
        name: data.name,
        externalSpriteURL: data.sprites.front_default,
      });
      fs.writeFileSync(path.join(__dirname, "cached-pokemon.json"), JSON.stringify(ALL_POKEMON, null, 2));
      console.log(`Got data for ${data.name}.`);
    } catch (error) { console.log(error); return; }
  }
  console.log("Finished getting pokemon data.");
}

function downloadImageTo(URL, filename){
  return new Promise((resolve, reject) => {
    https.request(URL, response => {
      const data = new Stream();
  
      response.on('data', function(chunk) {
        data.push(chunk);
      });
  
      response.on('end', function() {
        fs.writeFileSync(filename, data.read());
        resolve();
      });
    }).end();
  });
};

async function getPokemonImages() {
  let remainingPokemon = pokemonWithSprites().reverse();
  while (remainingPokemon.length) {
    let {
      sprite: spriteURL,
      name,
    } = remainingPokemon.pop();
    let imagePath = path.join(__dirname, "pokemon-images", `${name}.png`);
    if (fs.existsSync(imagePath)) { continue; }
    await downloadImageTo(spriteURL, imagePath);
    console.log(`Downloaded image for ${name}.`);
  }
  console.log(`Got all pokemon images.`);
}

(async function updateCache() {
  await getPokemonURLList();
  await getPokemon();
  await getPokemonImages();
})();

