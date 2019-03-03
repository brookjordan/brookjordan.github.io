var fuzzySearch = function () {

	return getFuzzyMatchArray;

	function getFuzzyMatchArray ( searchTerm, wordsList, sort ) {
		var matches = [];
		var match;
		searchTerm = searchTerm.toLowerCase();

		for ( var i = 0; i < wordsList.length; ++i ) {
			match = getWordData( searchTerm, wordsList[i] );
			if ( !!match ) {
				matches.push( match );
			}
		}

		if ( !!sort ) {
			matches.sort( sortByScore );
		}

		return matches;
	}

	function sortByScore ( a, b ) {
		if ( a.score === b.score ) {
			if ( a.string.replace( /[^\w\d]+/g, '' ).toLowerCase() > b.string.replace( /[^\w\d]+/g, '' ).toLowerCase() ) {
				return 1;
			}
			return -1;

		} else if ( a.score < b.score ) {
			return 1;
		}

		return -1;
	}

	function getWordData ( searchTerm, word ) {
		var unused = [];
		var used = [];
		var broken = '';
		var finding = '';
		var spare = '';
		var i;
		var j = 0;
		var score = 0;
		var multiplier = 1;
		var formatted = '';

		for ( i = 0; i < word.length; ++i ) {
			//	If we're at a space, try to do as little as possible
			if ( /\s/.test( word[i] ) ) {
				if ( finding.length ) {
					//	Prevent words with trailing spaces
					spare += word[i];
				} else {
					broken += word[i];
				}

			}
			//	If we're matching, add to the matching score
			else if ( word[i].toLowerCase() === searchTerm[j] ) {
				if ( i === 0 || broken.length ) {
					unused.push( broken );
					broken = '';
				}
				if ( i === 0 ) {
					multiplier  += 4;
				} else {
					multiplier  += (1/i)*2;
				}

				finding += spare + word[i];
				spare = '';

				do {
					++j;
				} while ( /\s/.test( searchTerm[j] ) )

			}
			//	Otherwise store then kill the current match we're building
			else {
				if ( finding.length ) {
					used.push( finding );
					finding = '';
				}

				broken += spare + word[i];
				spare = '';
			}

		}
		//	Clean up loose ends
		if ( finding.length ) {
			used.push( finding );
		}
		if ( used.length === unused.length ) {
			unused.push( broken );
		}



		if ( !searchTerm.length || used.length && j ) {
			for ( i = 0; i < used.length; ++i ) {
				score += Math.pow( 3, used[i].replace( /\s/g, '' ).length );
				formatted += unused[i] + '<strong>' + used[i] + '</strong>';
			}
			formatted += unused[i];

			return {
				searchTerm: searchTerm,
				string:     word,
				formatted:  formatted,
				baseScore:  score,
				score:      score*multiplier,
				multiplier: multiplier,
				used:       used,
				unused:     unused,
				fullMatch:  j === searchTerm.length
			};
		}

	}

}();

/*		minified	*/
//	var fuzzySearch=function(){function t(g,h){if(g.score===h.score){if(g.string.replace(/[^\w\d]+/g,"").toLowerCase()>h.string.replace(/[^\w\d]+/g,"").toLowerCase())return 1}else if(g.score<h.score)return 1;return-1}return function(g,h){var q=[],b;g=g.toLowerCase();for(var r=0;r<h.length;++r){b=g;for(var d=h[r],k=[],e=[],f="",c="",a=void 0,n=0,p=0,l=1,m="",a=0;a<d.length;++a)if(/\s/.test(d[a]))c.length?c+=d[a]:f+=d[a];else if(d[a].toLowerCase()===b[n]){if(0===a||f.length)k.push(f),f="";l=0===a?l+4:l+
//	1/a*2;c+=d[a];do++n;while(/\s/.test(b[n]))}else c.length&&(e.push(c),c=""),f+=d[a];c.length&&e.push(c);e.length===k.length&&k.push(f);if(!b.length||e.length&&n===b.length){for(a=0;a<e.length;++a)p+=Math.pow(3,e[a].replace(/\s/g,"").length),m+=k[a]+"<b>"+e[a]+"</b>";m+=k[a];b={searchTerm:b,string:d,formatted:m,baseScore:p,score:p*l,multiplier:l,used:e,unused:k}}else b=void 0;b&&q.push(b)}q.sort(t);return q}}();