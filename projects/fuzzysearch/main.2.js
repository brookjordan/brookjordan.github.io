let elt_container = document.getElementById( "results" );
let elt_search = document.getElementById( "search" );
let elt_progress = document.getElementById( "progress" );

let Matches = React.createClass({displayName: "Matches",
	render: function() {
		let matchNodes = matches
			.filter((match) => !!match.fullMatch)
			.map((match) => React.createElement("li",
				{ key:  match.string },
				React.createElement("span",
					{
						dangerouslySetInnerHTML: {
							__html: match.formatted
						}
					}
				),
				React.createElement("img",
					{
						src:  `./pokemon-images/${match.string}.png`,
						loading: "lazy",
						role: "presentation"
					}
				)
			));
		return (
			React.createElement("ul", null,
				matchNodes
			)
		);
	}
});

function printMatches () {
	matches = fuzzySearch( elt_search.value, nameList, true );

	React.render( React.createElement(Matches, null), elt_container) ;
}

elt_search.addEventListener( "keyup", function(){ printMatches(true) }, false );
