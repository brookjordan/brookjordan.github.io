let elt_container = document.getElementById( "results" );
let elt_search = document.getElementById( "search" );
let elt_progress = document.getElementById( "progress" );

class Matches extends preact.Component {
	render() {
		let matchNodes = matches
			.filter((match) => !!match.fullMatch)
			.map((match) => preact.createElement("li",
				{ key:  match.string },
				preact.createElement("span",
					{
						dangerouslySetInnerHTML: {
							__html: match.formatted.replace(/-/g, ' ')
						}
					}
				),
				preact.createElement("img",
					{
						src:  `./pokemon-images/${match.string}.png`,
						loading: "lazy",
						role: "presentation",
						width: 50,
						height: 50
					}
				)
			));
		return (
			preact.createElement("ul", null,
				matchNodes
			)
		);
	}
};

let component = null;
function printMatches () {
	matches = fuzzySearch( elt_search.value, nameList, true );

	if (component) {
		preact.render(preact.createElement(Matches, null), elt_container, component);
	} else {
		component = preact.render(preact.createElement(Matches, null), elt_container);
		rendered = true;
	}
}

elt_search.addEventListener( "keyup", function(){ printMatches(true) }, false );
