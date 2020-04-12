async function getLoadedImage(src) {
    let imageResponse = await fetch(src);
    if (!["2", "3"].includes(String(imageResponse.status).slice(0, 1))) {
        throw `Image is borked with status: ${imageResponse.status}`;
    }
    let imageBlob = await imageResponse.blob();
    let imageDataURL = URL.createObjectURL(imageBlob);
    let img = new Image();
    img.src = imageDataURL;
    return new Promise((resolve, reject) => {
        img.addEventListener("load", () => {
            resolve(img);
        }, { once: true });
        img.addEventListener("error", () => {
            reject("Image creation failed");
        }, { once: true });
    });
}

function batchArray (array, batchSize) {
    let batchedArray = [];
    for (let i = 0; i < array.length; i += batchSize) {
        batchedArray.push(array.slice(i, i + batchSize));
    }
    return batchedArray;
}

const POKEMON_NAMES = [
    "Bulbasaur",
    "Ivysaur",
    "Venusaur",
    "Charmander",
    "Charmeleon",
    "Charizard",
    "Squirtle",
    "Wartortle",
    "Blastoise",
    "Caterpie",
    "Metapod",
    "Butterfree",
    "Weedle",
    "Kakuna",
    "Beedrill",
    "Pidgey",
    "Pidgeotto",
    "Pidgeot",
    "Rattata",
    "Raticate",
    "Spearow",
    "Fearow",
    "Ekans",
    "Arbok",
    "Pikachu",
    "Raichu",
    "Sandshrew",
    "Sandslash",
    "Nidoran♀",
    "Nidorina",
    "Nidoqueen",
    "Nidoran♂",
    "Nidorino",
    "Nidoking",
    "Clefairy",
    "Clefable",
    "Vulpix",
    "Ninetales",
    "Jigglypuff",
    "Wigglytuff",
    "Zubat",
    "Golbat",
    "Oddish",
    "Gloom",
    "Vileplume",
    "Paras",
    "Parasect",
    "Venonat",
    "Venomoth",
    "Diglett",
    "Dugtrio",
    "Meowth",
    "Persian",
    "Psyduck",
    "Golduck",
    "Mankey",
    "Primeape",
    "Growlithe",
    "Arcanine",
    "Poliwag",
    "Poliwhirl",
    "Poliwrath",
    "Abra",
    "Kadabra",
    "Alakazam",
    "Machop",
    "Machoke",
    "Machamp",
    "Bellsprout",
    "Weepinbell",
    "Victreebel",
    "Tentacool",
    "Tentacruel",
    "Geodude",
    "Graveler",
    "Golem",
    "Ponyta",
    "Rapidash",
    "Slowpoke",
    "Slowbro",
    "Magnemite",
    "Magneton",
    "Farfetch'd",
    "Doduo",
    "Dodrio",
    "Seel",
    "Dewgong",
    "Grimer",
    "Muk",
    "Shellder",
    "Cloyster",
    "Gastly",
    "Haunter",
    "Gengar",
    "Onix",
    "Drowzee",
    "Hypno",
    "Krabby",
    "Kingler",
    "Voltorb",
    "Electrode",
    "Exeggcute",
    "Exeggutor",
    "Cubone",
    "Marowak",
    "Hitmonlee",
    "Hitmonchan",
    "Lickitung",
    "Koffing",
    "Weezing",
    "Rhyhorn",
    "Rhydon",
    "Chansey",
    "Tangela",
    "Kangaskhan",
    "Horsea",
    "Seadra",
    "Goldeen",
    "Seaking",
    "Staryu",
    "Starmie",
    "Mr. Mime",
    "Scyther",
    "Jynx",
    "Electabuzz",
    "Magmar",
    "Pinsir",
    "Tauros",
    "Magikarp",
    "Gyarados",
    "Lapras",
    "Ditto",
    "Eevee",
    "Vaporeon",
    "Jolteon",
    "Flareon",
    "Porygon",
    "Omanyte",
    "Omastar",
    "Kabuto",
    "Kabutops",
    "Aerodactyl",
    "Snorlax",
    "Articuno",
    "Zapdos",
    "Moltres",
    "Dratini",
    "Dragonair",
    "Dragonite",
    "Mewtwo",
    "Mew",
    "Chikorita",
    "Bayleef",
    "Meganium",
    "Cyndaquil",
    "Quilava",
    "Typhlosion",
    "Totodile",
    "Croconaw",
    "Feraligatr",
    "Sentret",
    "Furret",
    "Hoothoot",
    "Noctowl",
    "Ledyba",
    "Ledian",
    "Spinarak",
    "Ariados",
    "Crobat",
    "Chinchou",
    "Lanturn",
    "Pichu",
    "Cleffa",
    "Igglybuff",
    "Togepi",
    "Togetic",
    "Natu",
    "Xatu",
    "Mareep",
    "Flaaffy",
    "Ampharos",
    "Bellossom",
    "Marill",
    "Azumarill",
    "Sudowoodo",
    "Politoed",
    "Hoppip",
    "Skiploom",
    "Jumpluff",
    "Aipom",
    "Sunkern",
    "Sunflora",
    "Yanma",
    "Wooper",
    "Quagsire",
    "Espeon",
    "Umbreon",
    "Murkrow",
    "Slowking",
    "Misdreavus",
    "Unown",
    "Wobbuffet",
    "Girafarig",
    "Pineco",
    "Forretress",
    "Dunsparce",
    "Gligar",
    "Steelix",
    "Snubbull",
    "Granbull",
    "Qwilfish",
    "Scizor",
    "Shuckle",
    "Heracross",
    "Sneasel",
    "Teddiursa",
    "Ursaring",
    "Slugma",
    "Magcargo",
    "Swinub",
    "Piloswine",
    "Corsola",
    "Remoraid",
    "Octillery",
    "Delibird",
    "Mantine",
    "Skarmory",
    "Houndour",
    "Houndoom",
    "Kingdra",
    "Phanpy",
    "Donphan",
    "Porygon2",
    "Stantler",
    "Smeargle",
    "Tyrogue",
    "Hitmontop",
    "Smoochum",
    "Elekid",
    "Magby",
    "Miltank",
    "Blissey",
    "Raikou",
    "Entei",
    "Suicune",
    "Larvitar",
    "Pupitar",
    "Tyranitar",
    "Lugia",
    "Ho-Oh",
    "Celebi",
    "Treecko",
    "Grovyle",
    "Sceptile",
    "Torchic",
    "Combusken",
    "Blaziken",
    "Mudkip",
    "Marshtomp",
    "Swampert",
    "Poochyena",
    "Mightyena",
    "Zigzagoon",
    "Linoone",
    "Wurmple",
    "Silcoon",
    "Beautifly",
    "Cascoon",
    "Dustox",
    "Lotad",
    "Lombre",
    "Ludicolo",
    "Seedot",
    "Nuzleaf",
    "Shiftry",
    "Taillow",
    "Swellow",
    "Wingull",
    "Pelipper",
    "Ralts",
    "Kirlia",
    "Gardevoir",
    "Surskit",
    "Masquerain",
    "Shroomish",
    "Breloom",
    "Slakoth",
    "Vigoroth",
    "Slaking",
    "Nincada",
    "Ninjask",
    "Shedinja",
    "Whismur",
    "Loudred",
    "Exploud",
    "Makuhita",
    "Hariyama",
    "Azurill",
    "Nosepass",
    "Skitty",
    "Delcatty",
    "Sableye",
    "Mawile",
    "Aron",
    "Lairon",
    "Aggron",
    "Meditite",
    "Medicham",
    "Electrike",
    "Manectric",
    "Plusle",
    "Minun",
    "Volbeat",
    "Illumise",
    "Roselia",
    "Gulpin",
    "Swalot",
    "Carvanha",
    "Sharpedo",
    "Wailmer",
    "Wailord",
    "Numel",
    "Camerupt",
    "Torkoal",
    "Spoink",
    "Grumpig",
    "Spinda",
    "Trapinch",
    "Vibrava",
    "Flygon",
    "Cacnea",
    "Cacturne",
    "Swablu",
    "Altaria",
    "Zangoose",
    "Seviper",
    "Lunatone",
    "Solrock",
    "Barboach",
    "Whiscash",
    "Corphish",
    "Crawdaunt",
    "Baltoy",
    "Claydol",
    "Lileep",
    "Cradily",
    "Anorith",
    "Armaldo",
    "Feebas",
    "Milotic",
    "Castform",
    "Kecleon",
    "Shuppet",
    "Banette",
    "Duskull",
    "Dusclops",
    "Tropius",
    "Chimecho",
    "Absol",
    "Wynaut",
    "Snorunt",
    "Glalie",
    "Spheal",
    "Sealeo",
    "Walrein",
    "Clamperl",
    "Huntail",
    "Gorebyss",
    "Relicanth",
    "Luvdisc",
    "Bagon",
    "Shelgon",
    "Salamence",
    "Beldum",
    "Metang",
    "Metagross",
    "Regirock",
    "Regice",
    "Registeel",
    "Latias",
    "Latios",
    "Kyogre",
    "Groudon",
    "Rayquaza",
    "Jirachi",
    "Deoxys",
    "Turtwig",
    "Grotle",
    "Torterra",
    "Chimchar",
    "Monferno",
    "Infernape",
    "Piplup",
    "Prinplup",
    "Empoleon",
    "Starly",
    "Staravia",
    "Staraptor",
    "Bidoof",
    "Bibarel",
    "Kricketot",
    "Kricketune",
    "Shinx",
    "Luxio",
    "Luxray",
    "Budew",
    "Roserade",
    "Cranidos",
    "Rampardos",
    "Shieldon",
    "Bastiodon",
    "Burmy",
    "Wormadam",
    "Mothim",
    "Combee",
    "Vespiquen",
    "Pachirisu",
    "Buizel",
    "Floatzel",
    "Cherubi",
    "Cherrim",
    "Shellos",
    "Gastrodon",
    "Ambipom",
    "Drifloon",
    "Drifblim",
    "Buneary",
    "Lopunny",
    "Mismagius",
    "Honchkrow",
    "Glameow",
    "Purugly",
    "Chingling",
    "Stunky",
    "Skuntank",
    "Bronzor",
    "Bronzong",
    "Bonsly",
    "Mime Jr.",
    "Happiny",
    "Chatot",
    "Spiritomb",
    "Gible",
    "Gabite",
    "Garchomp",
    "Munchlax",
    "Riolu",
    "Lucario",
    "Hippopotas",
    "Hippowdon",
    "Skorupi",
    "Drapion",
    "Croagunk",
    "Toxicroak",
    "Carnivine",
    "Finneon",
    "Lumineon",
    "Mantyke",
    "Snover",
    "Abomasnow",
    "Weavile",
    "Magnezone",
    "Lickilicky",
    "Rhyperior",
    "Tangrowth",
    "Electivire",
    "Magmortar",
    "Togekiss",
    "Yanmega",
    "Leafeon",
    "Glaceon",
    "Gliscor",
    "Mamoswine",
    "Porygon-Z",
    "Gallade",
    "Probopass",
    "Dusknoir",
    "Froslass",
    "Rotom",
    "Uxie",
    "Mesprit",
    "Azelf",
    "Dialga",
    "Palkia",
    "Heatran",
    "Regigigas",
    "Giratina",
    "Cresselia",
    "Phione",
    "Manaphy",
    "Darkrai",
    "Shaymin",
    "Arceus",
    "Victini",
    "Snivy",
    "Servine",
    "Serperior",
    "Tepig",
    "Pignite",
    "Emboar",
    "Oshawott",
    "Dewott",
    "Samurott",
    "Patrat",
    "Watchog",
    "Lillipup",
    "Herdier",
    "Stoutland",
    "Purrloin",
    "Liepard",
    "Pansage",
    "Simisage",
    "Pansear",
    "Simisear",
    "Panpour",
    "Simipour",
    "Munna",
    "Musharna",
    "Pidove",
    "Tranquill",
    "Unfezant",
    "Blitzle",
    "Zebstrika",
    "Roggenrola",
    "Boldore",
    "Gigalith",
    "Woobat",
    "Swoobat",
    "Drilbur",
    "Excadrill",
    "Audino",
    "Timburr",
    "Gurdurr",
    "Conkeldurr",
    "Tympole",
    "Palpitoad",
    "Seismitoad",
    "Throh",
    "Sawk",
    "Sewaddle",
    "Swadloon",
    "Leavanny",
    "Venipede",
    "Whirlipede",
    "Scolipede",
    "Cottonee",
    "Whimsicott",
    "Petilil",
    "Lilligant",
    "Basculin",
    "Sandile",
    "Krokorok",
    "Krookodile",
    "Darumaka",
    "Darmanitan",
    "Maractus",
    "Dwebble",
    "Crustle",
    "Scraggy",
    "Scrafty",
    "Sigilyph",
    "Yamask",
    "Cofagrigus",
    "Tirtouga",
    "Carracosta",
    "Archen",
    "Archeops",
    "Trubbish",
    "Garbodor",
    "Zorua",
    "Zoroark",
    "Minccino",
    "Cinccino",
    "Gothita",
    "Gothorita",
    "Gothitelle",
    "Solosis",
    "Duosion",
    "Reuniclus",
    "Ducklett",
    "Swanna",
    "Vanillite",
    "Vanillish",
    "Vanilluxe",
    "Deerling",
    "Sawsbuck",
    "Emolga",
    "Karrablast",
    "Escavalier",
    "Foongus",
    "Amoonguss",
    "Frillish",
    "Jellicent",
    "Alomomola",
    "Joltik",
    "Galvantula",
    "Ferroseed",
    "Ferrothorn",
    "Klink",
    "Klang",
    "Klinklang",
    "Tynamo",
    "Eelektrik",
    "Eelektross",
    "Elgyem",
    "Beheeyem",
    "Litwick",
    "Lampent",
    "Chandelure",
    "Axew",
    "Fraxure",
    "Haxorus",
    "Cubchoo",
    "Beartic",
    "Cryogonal",
    "Shelmet",
    "Accelgor",
    "Stunfisk",
    "Mienfoo",
    "Mienshao",
    "Druddigon",
    "Golett",
    "Golurk",
    "Pawniard",
    "Bisharp",
    "Bouffalant",
    "Rufflet",
    "Braviary",
    "Vullaby",
    "Mandibuzz",
    "Heatmor",
    "Durant",
    "Deino",
    "Zweilous",
    "Hydreigon",
    "Larvesta",
    "Volcarona",
    "Cobalion",
    "Terrakion",
    "Virizion",
    "Tornadus",
    "Thundurus",
    "Reshiram",
    "Zekrom",
    "Landorus",
    "Kyurem",
    "Keldeo",
    "Meloetta",
    "Genesect",
    "Chespin",
    "Quilladin",
    "Chesnaught",
    "Fennekin",
    "Braixen",
    "Delphox",
    "Froakie",
    "Frogadier",
    "Greninja",
    "Bunnelby",
    "Diggersby",
    "Fletchling",
    "Fletchinder",
    "Talonflame",
    "Scatterbug",
    "Spewpa",
    "Vivillon",
    "Litleo",
    "Pyroar",
    "Flabébé",
    "Floette",
    "Florges",
    "Skiddo",
    "Gogoat",
    "Pancham",
    "Pangoro",
    "Furfrou",
    "Espurr",
    "Meowstic",
    "Honedge",
    "Doublade",
    "Aegislash",
    "Spritzee",
    "Aromatisse",
    "Swirlix",
    "Slurpuff",
    "Inkay",
    "Malamar",
    "Binacle",
    "Barbaracle",
    "Skrelp",
    "Dragalge",
    "Clauncher",
    "Clawitzer",
    "Helioptile",
    "Heliolisk",
    "Tyrunt",
    "Tyrantrum",
    "Amaura",
    "Aurorus",
    "Sylveon",
    "Hawlucha",
    "Dedenne",
    "Carbink",
    "Goomy",
    "Sliggoo",
    "Goodra",
    "Klefki",
    "Phantump",
    "Trevenant",
    "Pumpkaboo",
    "Gourgeist",
    "Bergmite",
    "Avalugg",
    "Noibat",
    "Noivern",
    "Xerneas",
    "Yveltal",
    "Zygarde",
    "Diancie",
    "Hoopa",
    "Volcanion",
    "Rowlet",
    "Dartrix",
    "Decidueye",
    "Litten",
    "Torracat",
    "Incineroar",
    "Popplio",
    "Brionne",
    "Primarina",
    "Pikipek",
    "Trumbeak",
    "Toucannon",
    "Yungoos",
    "Gumshoos",
    "Grubbin",
    "Charjabug",
    "Vikavolt",
    "Crabrawler",
    "Crabominable",
    "Oricorio",
    "Cutiefly",
    "Ribombee",
    "Rockruff",
    "Lycanroc",
    "Wishiwashi",
    "Mareanie",
    "Toxapex",
    "Mudbray",
    "Mudsdale",
    "Dewpider",
    "Araquanid",
    "Fomantis",
    "Lurantis",
    "Morelull",
    "Shiinotic",
    "Salandit",
    "Salazzle",
    "Stufful",
    "Bewear",
    "Bounsweet",
    "Steenee",
    "Tsareena",
    "Comfey",
    "Oranguru",
    "Passimian",
    "Wimpod",
    "Golisopod",
    "Sandygast",
    "Palossand",
    "Pyukumuku",
    "Type: Null",
    "Silvally",
    "Minior",
    "Komala",
    "Turtonator",
    "Togedemaru",
    "Mimikyu",
    "Bruxish",
    "Drampa",
    "Dhelmise",
    "Jangmo-o",
    "Hakamo-o",
    "Kommo-o",
    "Tapu Koko",
    "Tapu Lele",
    "Tapu Bulu",
    "Tapu Fini",
    "Cosmog",
    "Cosmoem",
    "Solgaleo",
    "Lunala",
    "Nihilego",
    "Buzzwole",
    "Pheromosa",
    "Xurkitree",
    "Celesteela",
    "Kartana",
    "Guzzlord",
    "Necrozma",
    "Magearna",
    "Marshadow",
    "Poipole",
    "Naganadel",
    "Stakataka",
    "Blacephalon",
    "Zeraora",
    "Meltan",
    "Melmetal",
    "Grookey",
    "Thwackey",
    "Rillaboom",
    "Scorbunny",
    "Raboot",
    "Cinderace",
    "Sobble",
    "Drizzile",
    "Inteleon",
    "Skwovet",
    "Greedent",
    "Rookidee",
    "Corvisquire",
    "Corviknight",
    "Blipbug",
    "Dottler",
    "Orbeetle",
    "Nickit",
    "Thievul",
    "Gossifleur",
    "Eldegoss",
    "Wooloo",
    "Dubwool",
    "Chewtle",
    "Drednaw",
    "Yamper",
    "Boltund",
    "Rolycoly",
    "Carkol",
    "Coalossal",
    "Applin",
    "Flapple",
    "Appletun",
    "Silicobra",
    "Sandaconda",
    "Cramorant",
    "Arrokuda",
    "Barraskewda",
    "Toxel",
    "Toxtricity",
    "Sizzlipede",
    "Centiskorch",
    "Clobbopus",
    "Grapploct",
    "Sinistea",
    "Polteageist",
    "Hatenna",
    "Hattrem",
    "Hatterene",
    "Impidimp",
    "Morgrem",
    "Grimmsnarl",
    "Obstagoon",
    "Perrserker",
    "Cursola",
    "Sirfetch'd",
    "Mr. Rime",
    "Runerigus",
    "Milcery",
    "Alcremie",
    "Falinks",
    "Pincurchin",
    "Snom",
    "Frosmoth",
    "Stonjourner",
    "Eiscue",
    "Indeedee",
    "Morpeko",
    "Cufant",
    "Copperajah",
    "Dracozolt",
    "Arctozolt",
    "Dracovish",
    "Arctovish",
    "Duraludon",
    "Dreepy",
    "Drakloak",
    "Dragapult",
    "Zacian",
    "Zamazenta",
    "Eternatus",
    "Zarude",
];

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

const connection = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
const TYPES = [
    {
        name: "wifi",
        isExpensive: false,
    },
    {
        name: "unknown",
        isExpensive: true,
    },
    {
        name: "bluetooth",
        isExpensive: true,
    },
    {
        name: "cellular",
        isExpensive: true,
    },
    {
        name: "ethernet",
        isExpensive: false,
    },
    {
        name: "none",
        isExpensive: true,
    },
    {
        name: "wimax",
        isExpensive: false,
    },
    {
        name: "other",
        isExpensive: true,
    },
];
const EXPENSIVE_TYPE_NAMES = TYPES
    .filter(type => type.isExpensive)
    .map(type => type.name);
const FAST_EFFECTIVE_TYPE_NAMES = ["5g", "4g", "3g"];
function updateConnectionStatus() {
    if (connection) {
        connectionDetails.speed = connection.effectiveType;
        connectionDetails.type = connection.type;
        connectionDetails.isStrong =
            !EXPENSIVE_TYPE_NAMES.includes(connection.type)
                && FAST_EFFECTIVE_TYPE_NAMES.includes(connection.effectiveType);
    }
    else {
        connectionDetails.speed = "4g";
        connectionDetails.type = "ethernet";
        connectionDetails.isStrong = true;
    }
}
const connectionDetails = {};
updateConnectionStatus();
if (connection) {
    connection.addEventListener("change", updateConnectionStatus);
}

let css = /*css*/ `
  *,
  ::before,
  ::after {
    box-sizing: border-box;
  }

  :host {
    display: block;
    position: relative;
    font-family: 'VT323', monospace;
  }

  img {
    display: none;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1;
    width: 100%;
    height: auto;
    pointer-events: none;
    transition:
      opacity 100ms ease-in,
      transform 100ms ease-in;
  }
  img,
  :host([reveal]:hover) img {
    opacity: 0;
    transform:
      translateY(-5px)
      scale(1)
    ;
  }
  :host([reveal]) img {
    display: block;
  }
  :host([reveal]) img {
    opacity: 1;
    transform:
      translateY(-5px)
      scale(1.5)
    ;
  }

  .grid {
    --fade: 200ms;
    display: grid;
    grid-template-columns: repeat(3, calc(100% / 3));
    transition:
      opacity 150ms ease-in;
  }
  .grid > div {
    --fade-order: 0;
    padding: 50%;
    background-color: transparent;
    transition: background-color var(--fade) ease-out;
    transition-delay: calc(var(--fade) / 3 * var(--fade-order));
  }
  .grid > div:nth-child(2) { --fade-order: 1; }
  .grid > div:nth-child(3) { --fade-order: 2; }
  .grid > div:nth-child(6) { --fade-order: 3; }
  .grid > div:nth-child(9) { --fade-order: 4; }
  .grid > div:nth-child(8) { --fade-order: 5; }
  .grid > div:nth-child(7) { --fade-order: 6; }
  .grid > div:nth-child(4) { --fade-order: 7; }
  .grid > div:nth-child(5) { --fade-order: 8; }
  :host([reveal]) img + .grid {
    opacity: 0.3;
  }
  :host([reveal]:hover) img + .grid {
    opacity: 1;
  }

  .name {
    display: none;
    position: absolute;
    top: calc(100% - 6px);
    left: 50%;
    transform:
      translateX(-50%)
      scale(1)
    ;
    padding: 3px 5px;
    margin: 0;
    background: rgba(0,0,0,0.7);
    color: var(--text-color, white);
    font-size: var(--font-size, 10px);
    line-height: 1;
    font-weight: 100;
    text-align: center;
    opacity: 0;
    transform-origin: 50% 0%;
    transition:
      opacity 150ms,
      transform 200ms
    ;
  }
  :host([reveal]) .name {
    display: block;
  }
  :host([reveal]:hover) .name {
    opacity: 1;
    transform:
      translateX(-50%)
      scale(2)
    ;
  }

  form {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: scale(0) translate(-50%, -50%);
    opacity: 0;
    transition: opacity 0.2s, transform 0.2s;
  }
  :host([guessing]) form {
    transform: scale(1) translate(-50%, -50%);
    opacity: 1;
  }
  [list="pokemon-list"] {
    font-size: 20px;
    font-size: min(26px, max(20px, 4vmin));
  }
`;
let pokemon3x3Template = document.createElement("template");
pokemon3x3Template.innerHTML = `
  <style>${css}</style>
  <div class="grid" id="grid">
    <div></div><div></div><div></div>
    <div></div><div></div><div></div>
    <div></div><div></div><div></div>
  </div>
  <form>
    <input list="pokemon-list">
    <button style="display:none"></button>
    <datalist id="pokemon-list"></datalist>
  </form>
  <h3 class="name" id="name"></h3>
`;
class Pokemon3x3 extends HTMLElement {
    constructor() {
        super();
        this.connectedCallbackCalled = false;
        this.attachShadow({ mode: "open" });
        this.shadowRoot.appendChild(pokemon3x3Template.content.cloneNode(true));
        this.guessForm = this.shadowRoot.querySelector('form');
        this.guessInput = this.shadowRoot.querySelector('[list="pokemon-list"]');
        this.gridElt = this.shadowRoot.querySelector("#grid");
        this.nameElt = this.shadowRoot.querySelector("#name");
        this.pokemonListElt = this.shadowRoot.querySelector("#pokemon-list");
        this.colorElts = Array.from(this.shadowRoot.querySelectorAll("#grid > div"));
        if (!this.guessInput) {
            console.log(this.guessInput);
        }
        this.guessListeners = [];
        this.pokemon = null;
        this.imageElt = null;
    }
    handleGridMouseEnter() { }
    ;
    static get observedAttributes() {
        return [
            "name",
            "reveal",
            "guessing",
        ];
    }
    addEventListener(eventName, callback, options) {
        if (eventName === "guess") {
            this.guessListeners.push({
                options,
                callback,
            });
        }
        else {
            super.addEventListener(eventName, callback, options);
        }
    }
    ;
    removeEventListener(eventName, callback, options) {
        if (eventName === "guess") {
            throw Error("removeEventListener isn’t supported for guess events yet.");
        }
        else {
            super.removeEventListener(eventName, callback, options);
        }
    }
    ;
    alertCorrectness(event) {
        event.preventDefault();
        this.guessListeners.forEach(guessListener => {
            guessListener.callback({
                guess: this.guessInput.value,
            });
        });
    }
    get guessing() {
        return typeof this.hasAttribute("guessing");
    }
    set guessing(value) {
        if (value == null || value === false) {
            this.removeAttribute("guessing");
        }
        else {
            this.setAttribute("guessing", "");
        }
    }
    get name() {
        return this.getAttribute("name");
    }
    set name(value) {
        this.setAttribute("name", value);
    }
    get reveal() {
        return this.hasAttribute("reveal");
    }
    set reveal(value) {
        if (value == null || value === false) {
            this.removeAttribute("reveal");
        }
        else {
            this.setAttribute("reveal", "");
        }
    }
    connectedCallback() {
        this.definePokemon().then(() => {
            this.connectedCallbackCalled = true;
        });
        this.guessForm.onsubmit = this.alertCorrectness.bind(this);
    }
    async attributeChangedCallback(key, oldValue, newValue) {
        if (oldValue !== newValue && this.connectedCallbackCalled) {
            if (key === "reveal") {
                this.addImageElt();
            }
            else if (key === "name") {
                this.definePokemon();
            }
            else if (key === "guessing") {
                if (newValue != null && newValue !== false) {
                    this.guessInput.focus();
                }
            }
        }
    }
    async definePokemon() {
        if (this.pokemon) {
            return;
        }
        if (!this.name) {
            throw "required-attr-error: Missing name attribute";
        }
        let allPokemon = await getPokemon();
        this.pokemon = allPokemon.find(aPokemon => aPokemon.name.toLowerCase() === this.name.toLowerCase());
        if (!this.pokemon) {
            throw `missing-pokemon-error: No pokémon exists with the name ${this.name}`;
        }
        this.colors = await this.pokemon.colors;
        this.colors.forEach((rgb, i) => {
            if (rgb) {
                this.colorElts[i].style.backgroundColor = `rgb(${rgb})`;
            }
            else {
                this.colorElts[i].style.backgroundColor = `transparent`;
            }
        });
        this.nameElt.textContent = this.pokemon.name;
        let pokemonDataListFragment = document.createDocumentFragment();
        allPokemon.forEach(({ name }) => {
            let optionElt = document.createElement("option");
            optionElt.value = name;
            pokemonDataListFragment.append(optionElt);
        });
        this.pokemonListElt.append(pokemonDataListFragment);
        if (this.imageElt) {
            this.imageElt.remove();
            this.imageElt = null;
            this.gridElt.removeEventListener("mouseenter", this.handleGridMouseEnter);
            this.gridElt.removeEventListener("touchstart", this.handleGridMouseEnter);
        }
        if (this.reveal) {
            this.handleGridMouseEnter = () => this.addImageElt();
            this.gridElt.addEventListener("mouseenter", this.handleGridMouseEnter);
            this.gridElt.addEventListener("touchstart", this.handleGridMouseEnter);
        }
    }
    addImageElt() {
        if (this.imageElt || !this.reveal) {
            return;
        }
        this.gridElt.removeEventListener("mouseenter", this.handleGridMouseEnter);
        this.gridElt.removeEventListener("touchstart", this.handleGridMouseEnter);
        this.imageElt = new Image();
        if (connectionDetails.isStrong) {
            this.imageElt.src = this.pokemon.image.bigSrc;
        }
        else {
            this.imageElt.src = this.pokemon.image.smallSrc;
        }
        this.imageElt.onload = () => {
            this.shadowRoot.insertBefore(this.imageElt, this.gridElt);
        };
    }
}
window.customElements.define("pokemon-3x3", Pokemon3x3);

let l;
let i;
function shuffle(array) {
    l = array.length;
    while (l) {
        i = Math.floor(Math.random() * l--);
        [array[i], array[l]] = [array[l], array[i]];
    }
    return array;
}

function findClosest(selector, element) {
    let elt = element;
    while (elt && elt !== document) {
        if (elt.matches(selector)) {
            return elt;
        }
        elt = elt.parentElement;
    }
}

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
    let shuffledPokemon = shuffle(pokemonData);
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
//# sourceMappingURL=bundle.js.map
