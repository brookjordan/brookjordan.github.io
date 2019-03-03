var pokedex;
var nameList;
var api = 'http://pokeapi.co';
var pokedex_url = 'http://pokeapi.co/api/v1/pokedex/';
var pokedex_xhr;
var matches = [];
var infoLoadingCount = 0;
var loadedInfo = 0;
var loadedImages = 0;
var loadedImageSrcs = 0;

var elt_container = document.getElementById( 'results' );
var elt_search = document.getElementById( 'search' );
var elt_progress = document.getElementById( 'progress' );

var Matches = React.createClass({displayName: "Matches",
	render: function() {
    	var matchNodes = matches
    		.filter(function(match){
    			if ( match.fullMatch ) {
    				return true;
    			}
    			return false;
    		})
	    	.map(function(match){
				return (
					React.createElement("li", {key:  match.string},
	                	React.createElement("span", {dangerouslySetInnerHTML: {__html: match.formatted}}),
						React.createElement("img", {src:  pokedex[ nameList.indexOf( match.string ) ].image})
					)
				);
			});
		return (
        	React.createElement("ul", null,
            	 matchNodes
            )
		);
	}
});

var updatedResults = false;

if ( localStorage.getItem( pokedex_url ) ) {
	sortPokedex ();

} else {
	pokedex_xhr = new XMLHttpRequest();
	pokedex_xhr.onreadystatechange = function ( data ) {
		if ( pokedex_xhr.readyState === 4 ) {
			localStorage.setItem( pokedex_url, pokedex_xhr.responseText );
			sortPokedex();
		}
	}
	pokedex_xhr.open( 'GET', pokedex_url, true );
	pokedex_xhr.send();
}

setInterval( printMatches, 100 )









//	FUNCTIONS	//
function printMatches ( force ) {
	if ( updatedResults || !!force ) {
		updatedResults = false;

		var str = '';

		matches = fuzzySearch( elt_search.value, nameList, true );

		React.render( React.createElement(Matches, null), elt_container) ;
	}
}

function sortPokedex () {
	pokedex = JSON.parse( localStorage.getItem( pokedex_url ) ).objects[0].pokemon;
	nameList = pokedex.map(function( item ){
		return item.name;
	});

	elt_progress.max = pokedex.length * 3;
	updateLoader( 'pokedex' );

	elt_search.addEventListener( 'keyup', function(){ printMatches(true) }, false );

	loadAnotherPokemon();
	loadAnotherPokemon();
	loadAnotherPokemon();
	loadAnotherPokemon();
	loadAnotherPokemon();

	loadAnotherPokemon();
	loadAnotherPokemon();
	loadAnotherPokemon();
	loadAnotherPokemon();
	loadAnotherPokemon();

	updatedResults = true;
}
function loadAnotherPokemon () {
	if ( infoLoadingCount < pokedex.length ) {
		getPokemonInfo( pokedex[ infoLoadingCount ] );
		++infoLoadingCount;
	} else {
		loadAnotherPokemon = function(){};
	}
}

function getPokemonInfo ( pokedexItem, i, _pokedex ) {
	pokedexItem.image = 'http://drh1.img.digitalriver.com/DRHM/Storefront/SiteImplementation/adbehap/adbehapSI/version/29/images/load_small.gif';
	pokedexItem.i = i;
	pokedexItem.dataURL = api + '/' + pokedexItem.resource_uri;

	var data_xhr = new XMLHttpRequest;

	if ( localStorage.getItem( pokedexItem.dataURL ) ) {
		usePokemonData ( pokedexItem );

	} else {
		data_xhr.onreadystatechange = function ( data ) {
			if ( data_xhr.readyState === 4 ) {

				localStorage.setItem( pokedexItem.dataURL, rebuildInfoObject( data_xhr.responseText ) );
				usePokemonData ( pokedexItem );
			}
		}
		data_xhr.open( 'GET', pokedexItem.dataURL, true );
		data_xhr.send();
	}
}
function rebuildInfoObject ( responseText ) {
	var data = JSON.parse( responseText );
	data = {
		name: data.name,
		sprites: data.sprites || []
	};

	return JSON.stringify( data );
}

function usePokemonData ( pokedexItem ) {
	pokedexItem.data = JSON.parse( localStorage.getItem( pokedexItem.dataURL ) );
	pokedexItem.name = pokedexItem.name;

	getPokemonSprite( pokedexItem );

	++loadedInfo;
	updateLoader( 'data' );

	updatedResults = true;
}

function getPokemonSprite ( pokedexItem ) {
	var spriteData_xhr;

	if ( pokedexItem.data.sprites && pokedexItem.data.sprites.length ) {
		pokedexItem.spriteURL = api + pokedexItem.data.sprites[0].resource_uri;

		if ( localStorage.getItem( pokedexItem.spriteURL ) ) {
			usePokemonSprite ( pokedexItem );

		} else {
			spriteData_xhr = new XMLHttpRequest;
			spriteData_xhr.onreadystatechange = function ( data ) {
				if ( spriteData_xhr.readyState === 4 ) {
					localStorage.setItem( pokedexItem.spriteURL, rebuildImageObject( spriteData_xhr.responseText ) );
					usePokemonSprite ( pokedexItem );
				}
			}
			spriteData_xhr.open( 'GET', pokedexItem.spriteURL, true );
			spriteData_xhr.send();
		}

	} else {
		usePokemonSprite ( pokedexItem );
	}

}
function rebuildImageObject ( responseText ) {
	var data = JSON.parse( responseText );
	data = {
		image: data.image
	};

	return JSON.stringify( data );
}

function usePokemonSprite ( pokedexItem ) {
	var imageData = JSON.parse( localStorage.getItem( pokedexItem.spriteURL ) );
	var imageURL = imageData && imageData.image ?
		api + imageData.image :
		'';

	++loadedImages;

	if ( !!imageURL ) {
		var img = new Image();
		img.onload = function () {
			pokedexItem.image = imageURL;
			++loadedImageSrcs;
			updateLoader( 'src' );
			loadAnotherPokemon();

			updatedResults = true;
		}
		img.src = imageURL;

	} else {
		++loadedImageSrcs;
		pokedexItem.image = imageURL;
		setTimeout( loadAnotherPokemon, 4 );
	}

	updateLoader( 'sprite' );

	updatedResults = true;
}

function updateLoader ( from ) {
	elt_progress.value = loadedInfo + loadedImages + loadedImageSrcs;

	if ( elt_progress.value === elt_progress.max ) {
		elt_progress.parentNode.removeChild( elt_progress );
		updateLoader = function(){};
	}
}