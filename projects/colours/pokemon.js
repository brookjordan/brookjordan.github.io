const pokedex = {
  'Bulbasaur': new Pokemon({
    index: 1,
    toEvolve: 25,
    evolution: 'Ivysaur',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Ivysaur': new Pokemon({
    index: 2,
    toEvolve: 100,
    evolution: 'Venusaur',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Venusaur': new Pokemon({
    index: 3,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Charmander': new Pokemon({
    index: 4,
    toEvolve: 25,
    evolution: 'Charmeleon',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Charmeleon': new Pokemon({
    index: 5,
    toEvolve: 100,
    evolution: 'Charizard',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Charizard': new Pokemon({
    index: 6,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Squirtle': new Pokemon({
    index: 7,
    toEvolve: 25,
    evolution: 'Wartortle',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Wartortle': new Pokemon({
    index: 8,
    toEvolve: 100,
    evolution: 'Blastoise',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Blastoise': new Pokemon({
    index: 9,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Caterpie': new Pokemon({
    index: 10,
    toEvolve: 12,
    evolution: 'Metapod',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Metapod': new Pokemon({
    index: 11,
    toEvolve: 50,
    evolution: 'Butterfree',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Butterfree': new Pokemon({
    index: 12,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Weedle': new Pokemon({
    index: 13,
    toEvolve: 12,
    evolution: 'Kakuna',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Kakuna': new Pokemon({
    index: 14,
    toEvolve: 50,
    evolution: 'Beedrill',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Beedrill': new Pokemon({
    index: 15,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Pidgey': new Pokemon({
    index: 16,
    toEvolve: 12,
    evolution: 'Pidgeotto',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Pidgeotto': new Pokemon({
    index: 17,
    toEvolve: 50,
    evolution: 'Pidgeot',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Pidgeot': new Pokemon({
    index: 18,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Rattata': new Pokemon({
    index: 19,
    toEvolve: 25,
    evolution: 'Raticate',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Raticate': new Pokemon({
    index: 20,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Spearow': new Pokemon({
    index: 21,
    toEvolve: 50,
    evolution: 'Fearow',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Fearow': new Pokemon({
    index: 22,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Ekans': new Pokemon({
    index: 23,
    toEvolve: 50,
    evolution: 'Arbok',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Arbok': new Pokemon({
    index: 24,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Pikachu': new Pokemon({
    index: 25,
    toEvolve: 50,
    evolution: 'Raichu',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Raichu': new Pokemon({
    index: 26,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Sandshrew': new Pokemon({
    index: 27,
    toEvolve: 50,
    evolution: 'Sandslash',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Sandslash': new Pokemon({
    index: 28,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Nidoran (female)': new Pokemon({
    index: 29,
    toEvolve: 25,
    evolution: 'Nidorina',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Nidorina': new Pokemon({
    index: 30,
    toEvolve: 100,
    evolution: 'Nidoqueen',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Nidoqueen': new Pokemon({
    index: 31,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Nidoran (male)': new Pokemon({
    index: 32,
    toEvolve: 25,
    evolution: 'Nidorino',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Nidorino': new Pokemon({
    index: 33,
    toEvolve: 100,
    evolution: 'Nidoking',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Nidoking': new Pokemon({
    index: 34,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Clefairy': new Pokemon({
    index: 35,
    toEvolve: 50,
    evolution: 'Clefable',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Clefable': new Pokemon({
    index: 36,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Vulpix': new Pokemon({
    index: 37,
    toEvolve: 50,
    evolution: 'Ninetales',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Ninetales': new Pokemon({
    index: 38,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Jigglypuff': new Pokemon({
    index: 39,
    toEvolve: 50,
    evolution: 'Wigglytuff',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Wigglytuff': new Pokemon({
    index: 40,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Zubat': new Pokemon({
    index: 41,
    toEvolve: 50,
    evolution: 'Golbat',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Golbat': new Pokemon({
    index: 42,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Oddish': new Pokemon({
    index: 43,
    toEvolve: 25,
    evolution: 'Gloom',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Gloom': new Pokemon({
    index: 44,
    toEvolve: 100,
    evolution: 'Vileplume',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Vileplume': new Pokemon({
    index: 45,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Paras': new Pokemon({
    index: 46,
    toEvolve: 50,
    evolution: 'Parasect',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Parasect': new Pokemon({
    index: 47,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Venonat': new Pokemon({
    index: 48,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Venomoth': new Pokemon({
    index: 49,
    toEvolve: 50,
    evolution: 'Diglett',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Diglett': new Pokemon({
    index: 50,
    toEvolve: 50,
    evolution: 'Dugtrio',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Dugtrio': new Pokemon({
    index: 51,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Meowth': new Pokemon({
    index: 52,
    toEvolve: 50,
    evolution: 'Persian',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Persian': new Pokemon({
    index: 53,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Psyduck': new Pokemon({
    index: 54,
    toEvolve: 50,
    evolution: 'Golduck',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Golduck': new Pokemon({
    index: 55,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Mankey': new Pokemon({
    index: 56,
    toEvolve: 50,
    evolution: 'Primeape',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Primeape': new Pokemon({
    index: 57,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Growlithe': new Pokemon({
    index: 58,
    toEvolve: 50,
    evolution: 'Arcanine',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Arcanine': new Pokemon({
    index: 59,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Poliwag': new Pokemon({
    index: 60,
    toEvolve: 25,
    evolution: 'Poliwhirl',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Poliwhirl': new Pokemon({
    index: 61,
    toEvolve: 100,
    evolution: 'Poliwrath',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Poliwrath': new Pokemon({
    index: 62,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Abra': new Pokemon({
    index: 63,
    toEvolve: 25,
    evolution: 'Kadabra',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Kadabra': new Pokemon({
    index: 64,
    toEvolve: 100,
    evolution: 'Alakazam',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Alakazam': new Pokemon({
    index: 65,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Machop': new Pokemon({
    index: 66,
    toEvolve: 25,
    evolution: 'Machoke',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Machoke': new Pokemon({
    index: 67,
    toEvolve: 100,
    evolution: 'Machamp',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Machamp': new Pokemon({
    index: 68,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Bellsprout': new Pokemon({
    index: 69,
    toEvolve: 25,
    evolution: 'Weepinbell',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Weepinbell': new Pokemon({
    index: 70,
    toEvolve: 100,
    evolution: 'Victreebel',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Victreebel': new Pokemon({
    index: 71,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Tentacool': new Pokemon({
    index: 72,
    toEvolve: 50,
    evolution: 'Tentacruel',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Tentacruel': new Pokemon({
    index: 73,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Geodude': new Pokemon({
    index: 74,
    toEvolve: 25,
    evolution: 'Graveler',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Graveler': new Pokemon({
    index: 75,
    toEvolve: 100,
    evolution: 'Golem',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Golem': new Pokemon({
    index: 76,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Ponyta': new Pokemon({
    index: 77,
    toEvolve: 50,
    evolution: 'Rapidash',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Rapidash': new Pokemon({
    index: 78,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Slowpoke': new Pokemon({
    index: 79,
    toEvolve: 50,
    evolution: 'Slowbro',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Slowbro': new Pokemon({
    index: 80,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Magnemite': new Pokemon({
    index: 81,
    toEvolve: 50,
    evolution: 'Magneton',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Magneton': new Pokemon({
    index: 82,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Farfetch\'d': new Pokemon({
    index: 83,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Doduo': new Pokemon({
    index: 84,
    toEvolve: 50,
    evolution: 'Dodrio',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Dodrio': new Pokemon({
    index: 85,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Seel': new Pokemon({
    index: 86,
    toEvolve: 50,
    evolution: 'Dewgong',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Dewgong': new Pokemon({
    index: 87,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Grimer': new Pokemon({
    index: 88,
    toEvolve: 50,
    evolution: 'Muk',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Muk': new Pokemon({
    index: 89,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Shellder': new Pokemon({
    index: 90,
    toEvolve: 50,
    evolution: 'Cloyster',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Cloyster': new Pokemon({
    index: 91,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Gastly': new Pokemon({
    index: 92,
    toEvolve: 25,
    evolution: 'Haunter',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Haunter': new Pokemon({
    index: 93,
    toEvolve: 100,
    evolution: 'Gengar',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Gengar': new Pokemon({
    index: 94,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Onix': new Pokemon({
    index: 95,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Drowzee': new Pokemon({
    index: 96,
    toEvolve: 50,
    evolution: 'Hypno',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Hypno': new Pokemon({
    index: 97,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Krabby': new Pokemon({
    index: 98,
    toEvolve: 50,
    evolution: 'Kingler',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Kingler': new Pokemon({
    index: 99,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Voltorb': new Pokemon({
    index: 100,
    toEvolve: 50,
    evolution: 'Electrode',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Electrode': new Pokemon({
    index: 101,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Exeggcute': new Pokemon({
    index: 102,
    toEvolve: 50,
    evolution: 'Exeggutor',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Exeggutor': new Pokemon({
    index: 103,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Cubone': new Pokemon({
    index: 104,
    toEvolve: 50,
    evolution: 'Marowak',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Marowak': new Pokemon({
    index: 105,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Hitmonlee': new Pokemon({
    index: 106,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Hitmonchan': new Pokemon({
    index: 107,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Lickitung': new Pokemon({
    index: 108,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Koffing': new Pokemon({
    index: 109,
    toEvolve: 50,
    evolution: 'Weezing',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Weezing': new Pokemon({
    index: 110,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Rhyhorn': new Pokemon({
    index: 111,
    toEvolve: 50,
    evolution: 'Rhydon',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Rhydon': new Pokemon({
    index: 112,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Chansey': new Pokemon({
    index: 113,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Tangela': new Pokemon({
    index: 114,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Kangaskhan': new Pokemon({
    index: 115,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Horsea': new Pokemon({
    index: 116,
    toEvolve: 50,
    evolution: 'Seadra',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Seadra': new Pokemon({
    index: 117,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Goldeen': new Pokemon({
    index: 118,
    toEvolve: 50,
    evolution: 'Seaking',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Seaking': new Pokemon({
    index: 119,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Staryu': new Pokemon({
    index: 120,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Starmie': new Pokemon({
    index: 121,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Mime': new Pokemon({
    index: 122,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Scyther': new Pokemon({
    index: 123,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Jynx': new Pokemon({
    index: 124,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Electabuzz': new Pokemon({
    index: 125,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Magmar': new Pokemon({
    index: 126,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Pinsir': new Pokemon({
    index: 127,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Tauros': new Pokemon({
    index: 128,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Magikarp': new Pokemon({
    index: 129,
    toEvolve: 100,
    evolution: 'Gyarados',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Gyarados': new Pokemon({
    index: 130,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Lapras': new Pokemon({
    index: 131,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Ditto': new Pokemon({
    index: 132,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Eevee': new Pokemon({
    index: 133,
    toEvolve: 25,
    evolution: 'Vaporeon',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Vaporeon': new Pokemon({
    index: 134,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Jolteon': new Pokemon({
    index: 135,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Flareon': new Pokemon({
    index: 136,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Porygon': new Pokemon({
    index: 137,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Omanyte': new Pokemon({
    index: 138,
    toEvolve: 50,
    evolution: 'Omastar',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Omastar': new Pokemon({
    index: 139,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Kabuto': new Pokemon({
    index: 140,
    toEvolve: 50,
    evolution: 'Kabutops',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Kabutops': new Pokemon({
    index: 141,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Aerodactyl': new Pokemon({
    index: 142,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Snorlax': new Pokemon({
    index: 143,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Articuno': new Pokemon({
    index: 144,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Zapdos': new Pokemon({
    index: 145,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Moltres': new Pokemon({
    index: 146,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Dratini': new Pokemon({
    index: 147,
    toEvolve: 25,
    evolution: 'Dragonair',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Dragonair': new Pokemon({
    index: 148,
    toEvolve: 100,
    evolution: 'Dragonite',
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Dragonite': new Pokemon({
    index: 149,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
  'Mewtwo': new Pokemon({
    index: 150,
    toEvolve: null,
    evolution: null,
    owned: {
      monster: 0,
      candy:   0,
    },
  }),
};

function Pokemon(options) {
  this.index          = options.index;
  this.toEvolve       = options.toEvolve;
  this.evolution      = options.evolution;
  this.owned          = options.owned;
  this.evolvableCount = () => {
    return this.toEvolve ? Math.max(0, Math.min(this.owned.monster, Math.floor((this.owned.candy + (this.owned.monster) - 1) / this.toEvolve))) : 0;
  };
}
